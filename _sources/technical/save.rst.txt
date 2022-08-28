Save Module
===========

The save module takes care of:

* Holding save data.
* The action of game saving.
* Storing the save data on disk.



Config
------


.. js:data:: global.save_file_path

    `<string>` The name of the file to which and from which save data is saved. (`save.sav` by default)



Globals
-------

.. js:data:: global.save_map

    `<map<any>>` The map holding all save information.



.. js:data:: global.save_sig

    `<string>` The string used to designate which savefile is currently selected.



Functions
---------

.. js:function:: save_init()

    Initializes the save module. Ran at game start, and includes the module config.



.. js:function:: save_cleanup()

    Destroys data structures used by the save module. Ran at game end.



.. js:function:: save_get(key, [default])

    Gets a save value with the provided key. If that value doesn't exist, default is returned (0 by default).

    **key** `<string or real>`

    **default** `<any>`



.. js:function:: save_set(key, value)

    Saves a value under the provided key.

    **key** `<string or real>`

    **value** `<any>`



.. js:function:: save_default(name)

    Resets a savefile to its default, new game, state. If a savefile name isn't provided, resets the current file.

    **name** `<string>`



.. js:function:: save_read()

    Loads save data from the save file on disk.



.. js:function:: save_write()

    Stores save data in the save file on disk.



.. js:function:: save_select(name)

    Selects a save with the provided name. This doesn't actually load any data when used - the performance cost is negligible.

    **name** `<string or real>` - Name of the save to select. If not a string, gets turned into one.