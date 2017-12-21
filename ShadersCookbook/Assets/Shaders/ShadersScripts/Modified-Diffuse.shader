Shader "Marcek/Modified Diffuse" {

Properties 
{
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
}

SubShader 
{
	Tags { "RenderType"="Opaque" }
	LOD 200

	CGPROGRAM
	#pragma surface surf Lambert
	#pragma multi_compile_instancing
	#pragma instancing_options procedural:setup

	sampler2D _MainTex;
	fixed4 _Color;

	struct Input 
	{		
		float2 uv_MainTex;
	};

#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED
	StructuredBuffer<float4> positionBuffer;
#endif

	void rotate2D(inout float2 v, float r)
	{
		float s, c;
		sincos(r, s, c);
		v = float2(v.x * c - v.y * s, v.x * s + v.y * c);
	}

	void setup()
	{
#ifdef UNITY_PROCEDURAL_INSTANCING_ENABLED

		float4 data = positionBuffer[unity_InstanceID];

		float rotation = data.w * data.w * _Time.y * 0.5f;
		rotate2D(data.xz, rotation);

		unity_ObjectToWorld._11_21_31_41 = float4(data.w, 0, 0, 0);
		unity_ObjectToWorld._12_22_32_42 = float4(0, data.w, 0, 0);
		unity_ObjectToWorld._13_23_33_43 = float4(0, 0, data.w, 0);
		unity_ObjectToWorld._14_24_34_44 = float4(data.xyz, 1);
		unity_WorldToObject = unity_ObjectToWorld;
		unity_WorldToObject._14_24_34 *= -1;
		unity_WorldToObject._11_22_33 = 1.0f / unity_WorldToObject._11_22_33;

#endif
	}

	void surf (Input IN, inout SurfaceOutput o) 
	{
		fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
		o.Albedo = c.rgb;
		o.Alpha = c.a;
	}
	ENDCG
}

CustomEditor "ModifiedDiffuseShaderGUI"
Fallback "Legacy Shaders/VertexLit"
}
