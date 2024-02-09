if (keyboard_check_pressed(vk_up)) blurriness++;
if (keyboard_check_pressed(vk_down)) blurriness = max(1, --blurriness);

surface_set_target(temp_surface);
draw_clear(c_black);

shader_set(shd_blur_h);
var u_tex_size = shader_get_uniform(shd_blur_h, "texture_size");
shader_set_uniform_f(u_tex_size, sprite_get_width(spr_bunny), sprite_get_height(spr_bunny));
var u_kernel_size = shader_get_uniform(shd_blur_h, "blur_radius");
shader_set_uniform_f(u_kernel_size, blurriness);
draw_sprite(spr_bunny, 0, 0, 0);
shader_reset();

surface_reset_target();




shader_set(shd_blur_v);
u_tex_size = shader_get_uniform(shd_blur_v, "texture_size");
shader_set_uniform_f(u_tex_size, sprite_get_width(spr_bunny), sprite_get_height(spr_bunny));
u_kernel_size = shader_get_uniform(shd_blur_v, "blur_radius");
shader_set_uniform_f(u_kernel_size, blurriness);
draw_surface(temp_surface, 0, 0);
shader_reset();


draw_text_colour(32, 32, $"FPS: {fps}", c_black, c_black, c_black, c_black, 1);
draw_text_colour(32, 48, $"Blurriness: {blurriness} ({2 * (2 * blurriness + 1)} texture fetches per fragment)", c_black, c_black, c_black, c_black, 1);