#version 130

  struct Material {
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
    float shininess;
  };

  struct Light {
    vec3 position;
    vec3 ambient;
    vec3 diffuse;
    vec3 specular;
  };

    out vec4 frag_col;

    in vec3 frag_3Dpos;
    in vec3 vs_normal;
    in vec2 vs_tex_coord;


    uniform Material material;
    uniform Light light;
    uniform Light light_2;
    uniform vec3 view_pos;

    void main() {
    //Light 1
    // Ambient

    vec3 ambient = light.ambient * material.ambient;
    vec3 light_dir = normalize(light.position - frag_3Dpos);

    // Diffuse

    float diff = max(dot(vs_normal, light_dir),0.0);
    vec3 diffuse = light.diffuse * diff * material.diffuse;

    // Specular

    vec3 view_dir = normalize(view_pos - frag_3Dpos);
    vec3 reflect_dir = reflect(-light_dir , vs_normal);
    float spec = pow(max(dot(view_dir , reflect_dir), 0.0), material.shininess);
    vec3 specular = light.specular * spec * material.specular;

    vec3 result1 = ambient + diffuse + specular;

    //Light2
    // Ambient
    
    vec3 ambient2 = light.ambient * material.ambient;
    vec3 light_dir2 = normalize(light_2.position - frag_3Dpos);

    // Diffuse

    float diff2 = max(dot(vs_normal, light_dir2),0.0);
    vec3 diffuse2 = light.diffuse * diff * material.diffuse;

    // Specular

    vec3 view_dir2 = normalize(view_pos - frag_3Dpos);
    vec3 reflect_dir2 = reflect(-light_dir2 , vs_normal);
    float spec2 = pow(max(dot(view_dir2 , reflect_dir2), 0.0), material.shininess);
    vec3 specular2 = light.specular * spec2 * material.specular;

    vec3 result2 = ambient2 + diffuse2 + specular2;

    vec3 result = result1 + result2;
    
    frag_col = vec4(result, 1.0);
    }