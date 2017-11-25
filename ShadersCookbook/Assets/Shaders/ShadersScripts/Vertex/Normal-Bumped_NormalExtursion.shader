// Unity built-in shader source. Copyright (c) 2016 Unity Technologies. MIT license (see license.txt)

Shader "Marcek/Vertex/Bumped Diffuse" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _BumpMap ("Normalmap", 2D) = "bump" {}
	_ExtursionTex("Extursion Map", 2D) = "bump"{}

	//MyCode
	_Amount ("Normal Extursion", Range(-0.1,0.1)) = 0
}

SubShader {
    Tags { "RenderType"="Opaque" }
    LOD 300

CGPROGRAM
#pragma surface surf Lambert vertex:vert

sampler2D _MainTex;
sampler2D _BumpMap;
sampler2D _ExtursionTex;
fixed4 _Color;

float _Amount;

struct Input {
    float2 uv_MainTex;
    float2 uv_BumpMap;
};

void vert(inout appdata_full v)
{
	float4 tex = tex2Dlod(_ExtursionTex, float4 (v.texcoord.xy, 0, 0));
	float extursion = tex.r * 3 - 1;
	v.vertex.xyz += v.normal * _Amount * extursion;
}


void surf (Input IN, inout SurfaceOutput o) {
    fixed4 c = tex2D(_MainTex, IN.uv_MainTex) * _Color;
    o.Albedo = c.rgb;
    o.Alpha = c.a;
    o.Normal = UnpackNormal(tex2D(_BumpMap, IN.uv_BumpMap));
}
ENDCG
}

FallBack "Legacy Shaders/Diffuse"
}
