Shader "Marcek/Lighting/Toon"
{
	Properties
	{
		_RampTex("Ramp Texture", 2D) = "white" {}
		_CelShadingLevels ("Cel shading levels", Range(0.0, 1.0)) = 1.0
		//_Transparency("Transparency", Range(0.0, 0.5)) = 0.25
		//_Transparency("Transparency", float) = 0.25
	}

	SubShader
	{

		CGPROGRAM
		#pragma	surface surf Toon
		#pragma 3.0

		sampler2D _RampTex;
		float _CelShadingLevels;

		struct Input
		{
			float2 uv_RampTex;
		};

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = tex2D(_RampTex, IN.uv_RampTex).rgb;
		}

		fixed4 LightingToon(SurfaceOutput s, fixed3 lightDir, fixed atten)
		{
			half NdotL = dot(s.Normal, lightDir);
			//NdotL = tex2D(_RampTex, fixed2(NdotL, 0.5));
			half cel = floor(NdotL * _CelShadingLevels) / (_CelShadingLevels - 0.5); // Snap

			fixed4 c;
			c.rgb = s.Albedo * _LightColor0.rgb * NdotL * cel * atten;
			c.a = s.Alpha;

			return c;
		}

		ENDCG
	}

}