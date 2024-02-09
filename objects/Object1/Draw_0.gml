if (keyboard_check_pressed(vk_up)) blurriness++;
if (keyboard_check_pressed(vk_down)) blurriness = max(1, --blurriness);
if (keyboard_check_pressed(vk_right)) sample_count++;
if (keyboard_check_pressed(vk_left)) sample_count = max(1, --sample_count);

shader_set(shd_blur_radial);
var u_tex_size = shader_get_uniform(shd_blur_radial, "texture_size");
shader_set_uniform_f(u_tex_size, sprite_get_width(spr_bunny), sprite_get_height(spr_bunny));
var u_kernel_size = shader_get_uniform(shd_blur_radial, "blur_radius");
var u_sample_count = shader_get_uniform(shd_blur_radial, "sample_count");
shader_set_uniform_f(u_kernel_size, blurriness);
shader_set_uniform_f(u_sample_count, sample_count);
draw_sprite(spr_bunny, 0, 0, 0);
shader_reset();


draw_text_colour(32, 32, $"FPS: {fps}", c_black, c_black, c_black, c_black, 1);
draw_text_colour(32, 48, $"Blurriness: {blurriness}", c_black, c_black, c_black, c_black, 1);
draw_text_colour(32, 64, $"Samples: {sample_count}", c_black, c_black, c_black, c_black, 1);