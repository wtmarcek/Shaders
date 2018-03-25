// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

//Shader "Custom/My First Lighting Shader" {
//
//	Properties{
//		_Tint("Tint", Color) = (1, 1, 1, 1)
//		_MainTex("Albedo", 2D) = "white" {}
//	[Gamma] _Metallic("Metallic", Range(0, 1)) = 0
//		_Smoothness("Smoothness", Range(0, 1)) = 0.1
//	}
//
//		SubShader{
//
//		Pass{
//		Tags{
//		"LightMode" = "ForwardBase"
//	}
//
//		CGPROGRAM
//
//#pragma target 3.0
//
//#pragma vertex vert
//#pragma fragment frag
//
//#include "LightUtilities.cginc"
//
//		ENDCG
//	}
//
//		Pass{
//		Tags{
//		"LightMode" = "ForwardAdd"
//	}
//
//		Blend One One
//		ZWrite Off
//
//		CGPROGRAM
//
//#pragma target 3.0
//
//#pragma vertex vert
//#pragma fragment frag
//
//#include "LightUtilities.cginc"
//
//		ENDCG
//	}
//	}
//}



Shader "Rendering/MultipleLights" {
	Properties
	{
		_MainTex("Main", 2D) = "white" {}
		_Tint("Main Tint", Color) = (1,1,1,1)
		[Gamma] _Metallic("Metallic", Range(0,1)) = 0
		_Smoothness("Smoothness", Range(0, 1)) = 0.1

	}

	SubShader
	{
		Pass
		{
			Tags{ "LightMode" = "ForwardBase" }

			CGPROGRAM

			#pragma target 3.0	

			#pragma vertex vert
			#pragma fragment frag

			#include "LightUtilities.cginc"

			ENDCG
		}

		Pass
		{
			Tags{ "LightMode" = "ForwardAdd" }
			Blend One One
			ZWrite Off

			CGPROGRAM

			#pragma target 3.0	

			#pragma vertex vert
			#pragma fragment frag

			#include "LightUtilities.cginc"

			ENDCG
		}
	}
	
}
//POINTLIGHT