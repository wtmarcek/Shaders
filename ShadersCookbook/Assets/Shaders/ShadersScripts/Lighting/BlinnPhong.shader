Shader "Marcek/Lighting/BlinnPhong"
{
	Properties
	{
		_MainTint("Main Tint", Color) = (1,1,1,1)
		_MainTex("Base RGB", 2D) = "white" {}
		_SpecularColor("Specular Color", Color) = (1,1,1,1)
		_SpecPower("Spcular Power", Range(0.1, 60)) = 3
	}

	SubShader
	{
		
		CGPROGRAM
		#pragma surface surf CustomBlinnPhong

		float4 _MainTint;
		sampler2D _MainTex;
		float4 _SpecularColor;
		float _SpecPower;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		fixed4 LightingCustomBlinnPhong(SurfaceOutput s, fixed3 lightDir, half3 viewDir, fixed atten)
		{
			float NdotL = max(0, dot(s.Normal, lightDir));

			float3 halfVector = normalize(lightDir + viewDir);
			float NdotH = max(0, dot(s.Normal, halfVector));
			float spec = pow(NdotH, _SpecPower) * _SpecularColor;

			float4 c;
			c.a = s.Alpha;
			c.rgb = (s.Albedo * _LightColor0 * NdotL) + (_LightColor0.rgb * _SpecularColor.rgb * spec) * atten;
			
			return c;
		}

		ENDCG
	}
}


//Shader "Custom/BlinnPhong" {
//	Properties {
//		_Color ("Color", Color) = (1,1,1,1)
//		_MainTex ("Albedo (RGB)", 2D) = "white" {}
//		_Glossiness ("Smoothness", Range(0,1)) = 0.5
//		_Metallic ("Metallic", Range(0,1)) = 0.0
//	}
//	SubShader {
//		Tags { "RenderType"="Opaque" }
//		LOD 200
//		
//		CGPROGRAM
//		// Physically based Standard lighting model, and enable shadows on all light types
//		#pragma surface surf Standard fullforwardshadows
//
//		// Use shader model 3.0 target, to get nicer looking lighting
//		#pragma target 3.0
//
//		sampler2D _MainTex;
//
//		struct Input {
//			float2 uv_MainTex;
//		};
//
//		half _Glossiness;
//		half _Metallic;
//		fixed4 _Color;
//
//		// Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
//		// See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
//		// #pragma instancing_options assumeuniformscaling
//		UNITY_INSTANCING_CBUFFER_START(Props)
//			// put more per-instance properties here
//		UNITY_INSTANCING_CBUFFER_END
//
//		void surf (Input IN, inout SurfaceOutputStandard o) {
//			// Albedo comes from a texture tinted by color
//			fixed4 c = tex2D (_MainTex, IN.uv_MainTex) * _Color;
//			o.Albedo = c.rgb;
//			// Metallic and smoothness come from slider variables
//			o.Metallic = _Metallic;
//			o.Smoothness = _Glossiness;
//			o.Alpha = c.a;
//		}
//		ENDCG
//	}
//	FallBack "Diffuse"
//}
