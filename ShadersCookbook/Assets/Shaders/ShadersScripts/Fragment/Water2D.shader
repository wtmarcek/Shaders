// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Marcek/Fragment/Water2D" {

	Properties 
	{
		_Color("Color", Color) = (1,1,1,1)
		_NormalMap("Normal", 2D) = "bump" {}
		_NoiseTex("Perlin Noise", 2D) = "white" {}
		
		_BumpMagnitude ("Normal Map Distortion", Range(0.0, 0.1)) = 0.1
		_WaveMagnitude("Wave Magnitude", Range(0.0, 0.5)) = 0.5
		_Period("Period", Range(0,100)) = 1
		_Scale("Scale", Range(0, 100)) = 1
	}

	SubShader
	{
		GrabPass {}

		Pass
		{

		CGPROGRAM

		#pragma fragment frag
		#pragma vertex vert
		#include "UnityCG.cginc"

		sampler2D _GrabTexture;
		sampler2D _NormalMap;
		sampler2D _NoiseTex;
		fixed4 _Color;

		float _Period;
		float _Scale;
		float _WaveMagnitude;
		float _BumpMagnitude;

		struct vertInput
		{
			float4 vertex : POSITION;
			float4 color : COLOR;
			float2 texcoord : TEXCOORD0;

			float4 worldPos : TEXCOORD1;
			float4 uvgrab : TEXCOORD2;
		};

		struct vertOutput
		{
			float4 vertex : POSITION;
			float4 color : COLOR;
			float2 texcoord : TEXCOORD0;

			float4 worldPos : TEXCOORD1;
			float4 uvgrab : TEXCOORD2;
		};

		vertOutput vert(vertInput v)
		{
			vertOutput o;

			o.texcoord = v.texcoord;
			o.vertex = UnityObjectToClipPos(v.vertex);
			o.uvgrab = ComputeGrabScreenPos(o.vertex);
			o.worldPos = mul(unity_ObjectToWorld, v.vertex);

			return o;
		}

		fixed4 frag (vertInput i) : COLOR
		{

			//Normal map distortion
			half4 bump = tex2D(_NormalMap, i.texcoord);
			half2 distortion1 = UnpackNormal(bump).rg;

			//Perlin noise distortion (wave distortion)
			float sinT = sin(_Time.w / _Period);
			float2 distortion2 = float2(tex2D(_NoiseTex, i.worldPos.xy / _Scale + float2(sinT, 0)).r -1.0, tex2D(_NoiseTex, i.worldPos.xy / _Scale + float2(0, sinT)).r -1.0);

			i.uvgrab.xy += (distortion2 * _WaveMagnitude) + (distortion1 * _BumpMagnitude);

			fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
				
			return col * _Color;
		}

		ENDCG
	}
	}
	FallBack "Diffuse"
}
