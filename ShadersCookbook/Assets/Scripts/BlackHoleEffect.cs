using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[ExecuteInEditMode] [RequireComponent(typeof(Camera))]
public class BlackHoleEffect : MonoBehaviour
{

    public Shader shader;
    public Transform blackHoleTrans;
    public float ratio = 1;
    public float radius = 0;

    private Camera cam;
    private Material _material;
    private Material material
    {
        get
        {
            if (_material == null)
            {
                _material = new Material(shader);
                _material.hideFlags = HideFlags.HideAndDontSave;
            }
            return _material;
        }
    }

    private void OnEnable()
    {
        cam = GetComponent<Camera>();
        ratio = 1f / cam.aspect;
    }

    private void OnDisable()
    {
        if (_material)
            Destroy(_material);
    }

    Vector3 blackHoleScreenPos;
    private void OnRenderImage(RenderTexture source, RenderTexture destination)
    {
        if (shader && material && blackHoleTrans)
        {
            blackHoleScreenPos = cam.WorldToScreenPoint(blackHoleTrans.position);

            if (blackHoleScreenPos.z > 0)
            {
                Vector2 normalizePosition = new Vector2(blackHoleScreenPos.x / cam.pixelWidth, blackHoleScreenPos.y / cam.pixelHeight);

                //Apply Shader params
                material.SetVector("_Position", normalizePosition);
                material.SetFloat("_Ratio", ratio);
                material.SetFloat("_Rad", radius);
                material.SetFloat("_Distance", Vector3.Distance(blackHoleScreenPos, transform.position));

                Graphics.Blit(source, destination, material);
            }
        }
    }
}