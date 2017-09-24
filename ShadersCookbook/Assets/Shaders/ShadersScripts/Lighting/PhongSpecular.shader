Shader "Marcek/Lighting/PhongSpecular"
{
	Properties
	{
		_MainTint("Diffuse Tint", Color) = (1,1,1,1)
		_MainTex("Base (RGB)", 2D) = "white" {}
		_SpecularColor("Specular Color", Color) = (1,1,1,1)
		_SpecularPower("Specular Power", Range(0, 30)) = 1
	}

	SubShader
	{
		CGPROGRAM
		#pragma surface surf Phong

		float4 _MainTint;
		sampler2D _MainTex;
		float4 _SpecularColor;
		float _SpecularPower;

		struct Input
		{
			float2 uv_MainTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_MainTex, IN.uv_MainTex).rgb;
		}

		fixed4 LightingPhong(SurfaceOutput s, fixed3 lightingDir, half3 viewDir, fixed atten)
		{
			//Reflection
			float NdotL = dot(s.Normal, lightingDir);
			float3 reflectionVector = normalize(2.0 * s.Normal * NdotL - lightingDir);

			//Specular
			float spec = pow(max(0, dot(reflectionVector, viewDir)), _SpecularPower);
			float3 finalSpec = _SpecularColor.rgb * spec;

			//FinalEffect
			fixed4 c;
			c.rgb = (s.Albedo * _LightColor0.rgb * max(0, NdotL) * atten) + (_LightColor0.rgb * finalSpec);
			c.a = s.Alpha;

			return c;
		}

		ENDCG
	}
}