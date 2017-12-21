using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

public class ModifiedDiffuseShaderGUI : ShaderGUI {

    MaterialEditor editor;
    MaterialProperty[] properties;

    public override void OnGUI(MaterialEditor editor, MaterialProperty[] properties)
    {
        //this.target = editor.target as Material;
        this.editor = editor;
        this.properties = properties;

        DoMain();
        //DoSecondary();
        DoAdvanced();
    }

    void DoMain() 
    {
        GUILayout.Label("Main Maps", EditorStyles.boldLabel);
        MaterialProperty mainTex = FindProperty("_MainTex", properties);
        GUIContent albedoLabel = new GUIContent("Albedo");
        MaterialProperty tint = FindProperty("_Color", properties);
        editor.TexturePropertySingleLine(albedoLabel, mainTex, tint);
        editor.TextureScaleOffsetProperty(mainTex);
    }

    void DoAdvanced()
    {
        GUILayout.Label("AdvancedOptions", EditorStyles.boldLabel);
        editor.EnableInstancingField();
    }

}
