#/bin/bash

cd ..
#models_complete
railroady -lamjtM | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' | neato -Tpng > doc/models_complete.png
railroady -o doc/models.dot -Mtjb --hide-magic --hide-types
neato -Tpng doc/models.dot > doc/models.png
#controllers_complete
railroady -lC | sed -r 's/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[m|K]//g' | neato -Tpng > doc/controllers_complete.png

