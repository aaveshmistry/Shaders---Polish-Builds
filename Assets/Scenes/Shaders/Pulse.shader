Shader "Custom/Pulse"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _color("Tint",Color) = (1,1,1,1)
	    _Fogcolor("Fog color",Color) =(0,0,0,0)
        _Depth("depth strength",float) = 1.0
        _Distance("depth distance",float) = -0.09
    }
    SubShader
    {
        // No culling or depth
        Cull Off ZWrite Off ZTest Always
  Tags { "RenderType"="Transparent" "Queue"="Transparent" }
//         LOD 200
       
//         ZWrite Off
    Blend SrcAlpha OneMinusSrcAlpha
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };
            struct Input
            {
                half fog;
            };
            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };
            v2f vert (appdata v)
            {
                v2f o;
              //  o.pos = UnityObjectToClipPos (v.vertex);
               // o.uv = ComputeScreenPos (o.pos);
               o.vertex = UnityObjectToClipPos(v.vertex);
                UNITY_TRANSFER_DEPTH(o.vertex);
                o.uv = v.uv;
                return o;
            }
            // half4 frag2(v2f T) : SV_Target
            // {
            // UNITY_OUTPUT_DEPTH(T.uv);
            // }

// void Fogcolor(Input IN,SurfaceOutput o, inout fixed4 color)
// 		{
// 		fixed3 fogcolor = _Fogcolor.rgb;
// 		#ifdef UNITY_PASS_FORWARDADD
// 		fogcolor = 0;
// 		#endif
// 		color.rgb = lerp(color.rgb,fogcolor,IN.fog);
// 		}
            sampler2D _MainTex;
            sampler2D _CameraDepthTexture; 
            half _Depth;
            half _Distance;
            fixed4 _color;
            fixed4 _Fogcolor;

            fixed4 frag(v2f i) : SV_Target
            {
             
                float4 col = tex2D(_MainTex, i.uv);
                float d = Linear01Depth(tex2D(_CameraDepthTexture, i.uv))*_ProjectionParams.z/_Distance;
                col.rgb = lerp(col.rgb, -0.3,0.7-saturate(d));
                col.rgb = lerp(col.rgb, 0, saturate(d));
                
               return col;
            }
            ENDCG
        }
    }
     FallBack "Diffuse"
}
