// The first version of the sphere

#define M_PI 3.1415926535897932384626433832795

bool inside(vec2 uv)
{
	if(uv.x*uv.x + uv.y*uv.y < 1.0)
	{
		return true;	
	}
	return false;
}

void main(void)
{
	float time = iGlobalTime;
	vec3 camera = vec3(0.0,0.0,5.0);
	vec2 uv = gl_FragCoord.xy / iResolution.xy;
	vec2 p = -1.0 + 2.0*uv;
	p.x *= iResolution.x / iResolution.y;
    float r = sqrt(p.x * p.x + p.y * p.y);    

	if(inside(p)) {
		float z = sqrt(1.0-p.x*p.x-p.y*p.y);
		float u = 0.5 + atan(z, p.x)/(2.0*M_PI);
		float v = asin(p.y);
		u += time/30.0;
        vec3 P = vec3(p.x,p.y,z);
		// Light vector
		vec3 L = P - camera;
		float len = length(L);
    	float diffuseDot = dot(-P, normalize(L));
        //float diffuse = clamp(diffuseDot, 0.0, 1.0) * len;
		vec3 col = diffuseDot*texture2D(iChannel0, vec2(u*3.0,v*3.0), -5.5).xyz;
	    col = col*0.3 + 0.7*col*col*(3.0-2.0*col);
		col *= 1.2*vec3(1.0, 1.05, 1.0);
        gl_FragColor.rgb = col;
	}
	else
		gl_FragColor.rgb = vec3(0,0,0);
	
}
