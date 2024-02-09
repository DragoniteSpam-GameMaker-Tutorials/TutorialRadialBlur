if (keyboard_check_pressed(vk_up)) blurriness++;
if (keyboard_check_pressed(vk_down)) blurriness = max(1, --blurriness);

shader_set(shd_blur_radial);
var u_tex_size = shader_get_uniform(shd_blur_radial, "texture_size");
shader_set_uniform_f(u_tex_size, sprite_get_width(spr_bunny), sprite_get_height(spr_bunny));
var u_kernel_size = shader_get_uniform(shd_blur_radial, "blur_radius");
shader_set_uniform_f(u_kernel_size, blurriness);
draw_sprite(spr_bunny, 0, 0, 0);
shader_reset();


draw_text_colour(32, 32, $"FPS: {fps}", c_black, c_black, c_black, c_black, 1);
draw_text_colour(32, 48, $"Blurriness: {blurriness} ({2 * (2 * blurriness + 1)} texture fetches per fragment)", c_black, c_black, c_black, c_black, 1);