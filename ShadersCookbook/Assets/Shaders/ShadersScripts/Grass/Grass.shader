Shader "Custom/Grass" {
	
	Properties
	{

	}
	SubShader{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		CGPROGRAM

		float _Length;
		float _Width;
		float _Gravity;

		struct geomInput
		{
			float4 pos : POSITION
			float4 nor : NORMAL
		};

		[maxvertcount(80)]
		void geom(triangle geomInput i[3], inout TriangleStream stream)
		{
			float4 P1 = i[0].pos;
			float4 P2 = i[1].pos;
			float4 P3 = i[2].pos;

			float4 N1 = i[0].nor;
			float4 N2 = i[1].nor;
			float4 N3 = i[2].nor;

			float4 P = (P1 + P2 + P3) / 3;
			float4 N = (N1 + N2 + N3) / 3;
			float4 T = float4(normalize((P2 - P1).xyz), 0.0f);

			for (int i = 0; i < _Steps; i++)
			{
				float t0 = (float)i / _Steps;
				float t1 = (float)(i + 1) / _Steps;

				float4 p0 = normalize(N - (float4(0, _Length * t0, 0, 0) * _Gravity * t0)) * (_Length * t0);
				float4 p1 = normalize(N - (float4(0, _Length * t1, 0, 0) * _Gravity * t1)) * (_Length * t1);

				float4 w0 = T * lerp(_Width, 0, t0);
				float4 w1 = T * lerp(_width, 0, t1);
			}
		}

		ENDCG
	}	
}
