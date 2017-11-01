Shader "Hidden/BlackHole"
{
	Properties
	{
		_MainTex ("Base (RGB)", 2D) = "white" {}
	}
	SubShader
	{
		Pass
		{
			Cull Off ZWrite Off ZTest Always

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma fragmentoption ARB_precision_hint_fastest 
			#include "UnityCG.cginc"
			
			#include "UnityCG.cginc"

			uniform sampler2D _MainTex;
			uniform float2 _Position;
			uniform float _Rad;
			uniform float _Ratio;
			uniform float _Distance;

			struct v2f
			{
				float4 pos : POSITION;
				float2 uv : TEXTCOORD0;
			};

			v2f vert(appdata_img v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.uv = v.texcoord;
				return o;
			}

			fixed4 frag (v2f i) : COLOR
			{
				float2 offset = i.uv - _Position;
				float2 ratio = {_Ratio, 1};
				float rad = length(offset / ratio); // the distance from the conventional "center" of the screen.
				float deformation = 1 / pow(rad*pow(_Distance, 0.5), 2)*_Rad * 2; // einstein black magic

				offset = offset * (1 - deformation);
				offset += _Position;

				half4 res = tex2D(_MainTex, offset);

				if (rad*_Distance<pow(0.3 * _Rad / _Distance, 0.5)*_Distance)
				{
					res = half4(0, 0, 0, 1);
				}

				return res;
			}
			ENDCG
		}
	}

	Fallback off
}