Shader "Marcek/Fragment/UsingGrabPass" {

Properties
{
	_MainTex("Main Texture", 2D) = "white" {}
	_BumpMap("Noise text", 2D) = "bump" {}
	_Color ("Color", Color) = (1,1,1,1)
	_Magnitude("Magnitude", Range(0,1)) = 0.05
}

SubShader
{
	Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Opaque" }

	GrabPass{}

	Pass
	{
	CGPROGRAM

	#pragma vertex vert
	#pragma fragment frag
	#include "UnityCG.cginc"

	sampler2D _GrabTexture;
	sampler2D _MainTex;
	sampler2D _BumpMap;
	float _Magnitude;
	float4 _Color;

	struct vertInput
	{
		float4 vertex : POSITION;
		float2 texcoord : TEXCOORD0;
	};

	struct vertOutput
	{
		float4 vertex : POSITION;
		float2 texcoord : TEXCOORD0;
		float4 uvgrab: TEXCOORD1;
	};

	vertOutput vert(vertInput v)
	{
		vertOutput o;
		o.vertex = UnityObjectToClipPos(v.vertex);
		o.texcoord = v.texcoord;
		o.uvgrab = ComputeGrabScreenPos(o.vertex);
		return o;
	}

	half4 frag(vertOutput i) : COLOR
	{
		half4 mainColor = tex2D(_MainTex, i.texcoord);
		half4 bump = tex2D(_BumpMap, i.texcoord);
		half2 distortion = UnpackNormal(bump).rg;

		i.uvgrab.xy += distortion * _Magnitude;

		fixed4 col = tex2Dproj(_GrabTexture, UNITY_PROJ_COORD(i.uvgrab));
		return col * mainColor * _Color;
	}

	ENDCG
	}
}
}