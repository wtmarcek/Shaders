Shader "Marcek/Vertex/VertexColor" {

	Properties
	{
		_MainTint("Global Color Tint", Color) = (1,1,1,1)
	}

	SubShader
	{

		Tags { "RenderType" = "Transparent" }

		CGPROGRAM
		#pragma surface surf Lambert vertex:vert 

		float4 _MainTint;	

		struct Input
		{
			float2 uv_MainTex;
			float4 vertColor;
		};

		void vert(inout appdata_full v, out Input o)
		{
			UNITY_INITIALIZE_OUTPUT(Input, o);
			o.vertColor = v.color;
		}

		void surf(Input IN, inout SurfaceOutput o)
		{
			o.Albedo = IN.vertColor.rgb /** _MainTint.rgb * 0.1*/;
			o.Alpha = 0.1;
		}

		ENDCG
	}
	//FallBack "Diffuse"
}
