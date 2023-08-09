# zen-old-typewriter-mode for Doom Emacs

Make your Emacs sound like a zen old typewriter. This was a simple joke, that with Emacs you can customize it to be what ever you like in a simple way with zero experience! Emacs has a beautifull design, but this turn out to bacame something that I really like to use, it is really a calm and Zen thing to type all day with this mode turned on.
I only use Emacs for 4 days know, and my Emacs LISP is by intuition and from what I remembered of Common LISP from the 90s in a IA subject from college, so this reimplementation that I made from selectric, should not be anything to brag about. But incredibly it works, and all the errors that I have found, I corrected them. 

I found the selectic-mode and found the idea really cool, but didn't like the sounds, so first I changed the sounds of the key, them I added many more different sound to different mapped keys, then it become a really big mess and so I started to search for alternative methods to mode key definition. Then I reimplemented all the code almost from scratch but with a completly different approach that didn't relly on key definitions for RET, BackSpace or SPC.
Then I cleaned all the things, wrote or modified this readme.md and shared with friends.

Note: My many thanks go to selectric-mode author, this wasn't possible without the selectric-mode for emacs because this started to be a small change of a sound of selectric type, parte after parte change after change it become a reimplementation with a different method then key bindings. I am starting to use Doom Emacs with Evil VIM mode, and so this was tested only in it.
Maybe it works on vanila Emacs, I don't know. 


To install it, simply add it to your load-path, require it:

```elisp
(add-to-list 'load-path "~/.emacs.d/plugins/zen-old-typewriter-mode")
(require 'zen-old-typewriter-mode)
```

And then activate/deactivate with M-x `zen-old-typewriter-mode`. When it's
activated.

Best regards,
Joao Carvalho