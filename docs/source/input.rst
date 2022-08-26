Input module
============

The input module takes care of:

* Abstracting keyboard and gamepad input into one system.
* Rebinds for both input methods.

For clarity, **keys** refer to keyboard keys, **buttons** refer to gamepad buttons, and **inputs** refer to the in-game controls that can check for both keys and controls.

Config
------

.. js:data:: global.input_file_path

    `<string>` The name of the file to which and from which rebind data is saved. (binds.ini by default)



.. js:data:: global.input_map

    `<map<input_definition>>` The map holding all available inputs used in the game.



Functions
---------

.. js:data:: INPUT

    Enum holding the names of every avaiable input.



.. js:function:: input_init()

    Initializes the input module. Ran at game start, and includes the module config.



.. js:function:: input_cleanup()

    Destroys data structures used by the input module. Ran at game end.



.. js:function:: input_write()

    Saves the rebind configuration to the config file.



.. js:function:: input_read()

    Reads the rebind configuration from the config file.



.. js:function:: new input_definition(name, default_key, default_button, rebindable)

    Constructor that returns a new input struct, used to define all available inputs in :js:func:`input_init`

    **name** `<string>` - Name of the input. Shown in the rebind screen.

    **key** `<vk_*> or ord("A..Z")` - Default keyboard key.

    **button** `<gp_*>` - Default gamepad button.

    **rebindable** `<bool>` - Whether the key is shown in the rebind screen.



.. js:function:: input_check(input)

    Checks if an input is currently held.

    **input** `<INPUT.*>` - Input to check.



.. js:function:: input_check_pressed(input)

    Checks if an input has been pressed on this frame.

    **input** `<INPUT.*>` - Input to check.



.. js:function:: input_check_released(input)

    Check if an input has been released on this frame.

    **input** `<INPUT.*>` - Input to check.



.. js:function:: input_get_name(input)

    Gets the name of an input.

    **input** `<INPUT.*>` - Input to get the name of.



.. js:function:: input_get_key(input)

    Gets the keyboard key of an input.

    **input** `<INPUT.*>` - Input to get the keyboard key of.



.. js:function:: input_get_button(input)

    Gets the gamepad button of an input.

    **input** `<INPUT.*>` - Input to get the gamepad button of.



.. js:function:: input_bind_key(input, key)

    Binds an input to a new key.

    **input** `<INPUT.*>` - Input to rebind.

    **key** `<vk_*> or ord("A..Z")` - The new key for the input.



.. js:function:: input_bind_button(input, button)

    Binds an input to a new button.

    **input** `<INPUT.*>` - Input to rebind.

    **button** `<gp_*>` - The new key for the button.



.. js:function:: input_default_keys()

    Resets all keys to their default.



.. js:function:: input_default_buttons()

    Resets all buttons to their default.



    