Shader "Rendering/TextureCombine" {

	Properties 
	{
		_Tint ("Tint", Color) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_Float ("f", Float) = 10
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _Tint;

			float _Float;

			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv_MainTex : TEXCOORD0;
			};

			struct VertexData
			{
				float4 position : POSITION;
				float2 uv_MainTex : TEXCOORD0;
			};

			Interpolators vert(VertexData v)
			{
				Interpolators i;
				i.position = UnityObjectToClipPos(v.position);
				i.uv_MainTex = v.uv_MainTex;
				return i;
			}

			float4 frag(Interpolators i) : SV_TARGET
			{
				float4 color = tex2D(_MainTex, i.uv_MainTex * _Float) * _Tint;
				color *= tex2D(_MainTex, i.uv_MainTex) * 2;
				
				return color;
			}

			ENDCG
		}
	}
}
