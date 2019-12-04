using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(Camera))]
public class Pulse : MonoBehaviour
{

    public Material shaderMaterial;
  public  float _Distance = 0;
  float acceleration;
    Vector2 depthtex;
    public bool activated;
    public float Distance
    {
        get { return _Distance; }
        set { _Distance = value; }
    }
    void Start()
    {
        
        GetComponent<Camera>().depthTextureMode = DepthTextureMode.Depth;
    }
private void Update() 
{
    if(Input.GetKeyDown(KeyCode.E))
    {
        activated = true;
       
    }
    if(activated)
    {
        acceleration ++;
 _Distance += 5*Time.deltaTime*acceleration;
    }
    if(_Distance >= 1000)
    {
        acceleration = 0;
        activated = false;
        _Distance = 0;
    }
}
    void OnRenderImage(RenderTexture src, RenderTexture dest)
    {
        //Vector2 dist = new Vector2(transform.position.x, transform.position.y);
        shaderMaterial.SetFloat("_Distance", _Distance);
        Graphics.Blit(src, dest, shaderMaterial);
    }
}
