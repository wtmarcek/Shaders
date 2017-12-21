using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class MultipleInstancer : MonoBehaviour
{

    [SerializeField]
    GameObject obj;

    [SerializeField]
    int instNumber;
    [SerializeField]
    float sphereRadius = 50;

    void Start()
    {
        Vector3 currentPos = transform.position;
        //float objXSpread = obj.transform.localScale.x;
        for (int i = 0; i <= instNumber; i++)
        {
            if (currentPos.x < 50)
            {
                currentPos = new Vector3(currentPos.x + 1, currentPos.y, 0);
            }
            else
            {
                currentPos = new Vector3(0, currentPos.y + 1, 0);
            }
            Instantiate(obj, Random.insideUnitSphere * sphereRadius, Quaternion.identity, transform);
        }
        print(100 % 13);
    }

    void Update()
    {

    }
}
