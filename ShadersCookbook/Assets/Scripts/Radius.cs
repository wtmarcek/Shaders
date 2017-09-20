using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Radius : MonoBehaviour {

    [SerializeField]
    Material radiusMaterial;
    [SerializeField]
    float radius = 1.0f;
    [SerializeField]
    Color color = Color.white;

	void Update ()
    {
        radiusMaterial.SetVector("_Center", transform.position);
        radiusMaterial.SetFloat("_Radius", radius);
        radiusMaterial.SetColor("_RadiusColor", color);
	}
}
