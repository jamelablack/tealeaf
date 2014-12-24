If you run binding.pry in your controller action, you can type the following in
your console after entering data in your:

params - will list the params available

post_params = will list those entered

params.require(:post).permit(:title) => strong parameters
