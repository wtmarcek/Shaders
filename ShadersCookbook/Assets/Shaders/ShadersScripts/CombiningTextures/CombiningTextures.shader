Shader "Rendering/TextureCombine" {

	Properties
	{
		_Tint("Tint", Color) = (1,1,1,1)
		_MainTex("Albedo (RGB)", 2D) = "white" {}

	}

		SubShader
	{
		Pass
	{
		CGPROGRAM

#pragma vertex vert
#pragma fragment frag

		sampler2D _MainTex;
	float4 _Tint;

	struct Interpolator
	{
		float uv_MainTex : TEXCOORD0;
	};

	void vert()
	{
		return;
	}

	float4 frag(Interpolator i) : SV_TARGET
	{
		float4 color = tex2D(_MainTex, i.uv_MainTex) * _Tint;
		return color;
	}

		ENDCG
	}
	}
		//FallBack "Diffuse"
}
