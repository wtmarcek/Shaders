﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Rendering/Metallic" {
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

			#pragma vertex vert
			#pragma fragment frag

			#include "UnityStandardBRDF.cginc"
			#include "UnityStandardUtils.cginc"

			sampler2D _MainTex;
			float4 _Tint;
			float4 _MainTex_ST;

			float _Smoothness;
			float _Metallic;

			struct VertexData
			{
				float4 position : POSITION;
				float3 normal : NORMAL;
				float2 uv : TEXCOORD0;
			};

			struct Interpolators
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
			};

			Interpolators vert(VertexData v)
			{
				Interpolators i;
				i.position = UnityObjectToClipPos(v.position);
				i.worldPos = mul(unity_ObjectToWorld, v.position);
				i.normal = UnityObjectToWorldNormal(v.normal);
				i.normal = normalize(i.normal);
				i.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return i;
			}

			float4 frag(Interpolators i) : SV_TARGET
			{
				i.normal = normalize(i.normal);
				float3 lightDir = _WorldSpaceLightPos0.xyz;
				float3 lightColor = _LightColor0.rgb;
				float3 viewDir = normalize(_WorldSpaceCameraPos - i.worldPos);

				float3 albedo = tex2D(_MainTex, i.uv).rgb * _Tint.rgb;
				//float3 specularTint = albedo * _Metallic;
				//float oneMinusReflectivity = 1 - _Metallic;
				//albedo *= oneMinusReflectivity;
				float3 specularTint;
				float oneMinusReflectivity;
				albedo = DiffuseAndSpecularFromMetallic(albedo, _Metallic, specularTint, oneMinusReflectivity);

				float3 diffuse = albedo * lightColor * (DotClamped(lightDir, i.normal));
				float3 halfVector = normalize(lightDir + viewDir);

				float3 spec = specularTint * lightColor * pow(DotClamped(halfVector, i.normal), _Smoothness * 100);

				return float4((diffuse + spec).rgb ,1);
			}

		ENDCG
		}
	}
		FallBack "Diffuse"
}
