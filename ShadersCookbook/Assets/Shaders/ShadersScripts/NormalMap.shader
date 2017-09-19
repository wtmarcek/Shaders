Shader "Marcek/NormalMap" {
	Properties {
		_MainTint("Diffuse Tint", Color) = (1,1,1,1)
		_NormalMapIntensity("Normal Map Intensity", Range(0,1)) = 1
		_NormalTex("Normal MaP", 2D) = "bump" {}
	}
	SubShader {
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		// Physically based Standard lighting model, and enable shadows on all light types
		#pragma surface surf Lambert /*fullforwardshadows*/

		// Use shader model 3.0 target, to get nicer looking lighting
		#pragma target 3.0

		sampler2D _NormalTex;
		float4 _MainTint;
		float _NormalMapIntensity;

		struct Input {
			float2 uv_NormalTex;
		};

		void surf (Input IN, inout SurfaceOutput o) {
			o.Albedo = _MainTint;

			float3 n = UnpackNormal(tex2D(_NormalTex, IN.uv_NormalTex)).rgb;
			n.x *= _NormalMapIntensity;
			n.y *= _NormalMapIntensity;
			o.Normal = normalize(n);
		}
		ENDCG
	}
	FallBack "Diffuse"
}
