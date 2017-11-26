// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Marcek/Fragment/FragmentExampe" {
	Properties 
	{
		_Color ("Color", Color) = (1,0,0,1)
		_MainTex("Base texture", 2D) = "white" {}
	}

		SubShader
	{
		Tags { "RenderType" = "Opaque" }
		LOD 200

		Pass
		{
		CGPROGRAM

		#pragma vertex vert
		#pragma fragment frag

		float4 _Color;
		sampler2D _MainTex;

		struct vertInput
		{
			float4 pos: POSITION;
			float2 texcoord : TEXCOORD0;
		};

		struct vertOutput
		{
			float4 pos : POSITION;
			float2 texcoord : TEXCOORD0;
		};

		vertOutput vert(vertInput input)
		{
			vertOutput o;
			o.pos = UnityObjectToClipPos(input.pos);
			o.texcoord = input.texcoord;
			return o;
		}

		half4 frag (vertOutput output) : COLOR
		{
			 half4 mainColor = tex2D(_MainTex, output.texcoord);
			 return mainColor * _Color;
		}
		

		ENDCG
		}

	}
	FallBack "Diffuse"
}
