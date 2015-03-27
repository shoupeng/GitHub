// This code is in lesson1.rsc.
Macro 'lesson1'
	
    // Set up the arguments for the nearest points macro; by setting these
    // in variables it is easier to read the actual RunMacro() call and know 
    // what is being passed.

    // Specify a layer name in the current map; layer names are
    // case sensitive.
    layer = 'Place'

    // Use an arbitrary coordinate near Boston for now.  Coordinates are
    // given as integer millionths of degrees, longitude first, then latitude.
    // This coordinate is at -71.123456 degrees longitude and 42.456321 
    // degrees latitude.
    clicked_point = Coord(-71092100, 42320800)

    // Set a search distance of 5 miles, based on the current map units.
    current_units = GetMapUnits("Plural")
    distance = 5 * GetUnitSize("Miles", current_units)

    // Call the nearest points macro.
    result = RunMacro("get nearest points", layer, clicked_point, distance)

    // Show the list of nearest points.
    ShowArray(result)

endMacro


// A macro to get the nearest points on the search layer
Macro "get nearest points" (search_layer, subject_point, search_distance)

    // Each macro should have a description at the beginning:
    // Finds points within search_distance units of subject_point on 
    // search_layer and returns an array containing a data array for each
    // point, with distance, city and state; the data arrays are in order
    // by distance. This macro is designed to work with the Place layer
    // in Lessons.map.

    // Store the current layer, then make the specified layer the working layer.
    curr_layer = GetLayer()
    SetLayer(search_layer)

    // Find the nearest points in the working layer and return, in array rhs,
    // the record handles (the string form of the record ID) for the closest 
    // records. The last argument, an options array, can be null.
    rhs = LocateNearestRecords(subject_point, search_distance, null)

    // If no points were found then display message and return.
    if rhs = null then do
        ShowMessage('Sorry, no points were within your search distance.')
    // Reset the layer to the stored layer; this is very important when an
    // add-in is working with the standard interface
    SetLayer(curr_layer)

        return()
        end    
 
    // Dimension an array to the length of the record handles (rhs) array.
    Dim data[rhs.length]

    // Look through the record handles array.
    for i = 1 to rhs.length do

        // Use the record handle to set the current record position on the 
        // current view (which in this case is the Place layer).
        SetRecord(, rhs[i])

        // Get the point coordinate for the current record on the current layer,
        // converting the record handle to its numeric equivalent (an ID).
        target_point = GetPoint(rh2id(rhs[i]))

        // Get the distance between the clicked point and the current point.
        distance = GetDistance(subject_point, target_point)

        // Add data to the output array. To add data from a current record for 
        // a layer use a "field specification", which is the layer name in 
        // a variable + "." + field name, e.g. layer.city, not Place.city.
        data[i]={distance, search_layer.city, search_layer.state, target_point}
        end  // end of record handles loop

    // Reset the layer and return the data array to the calling program 
    SetLayer(curr_layer)
    return(data)

EndMacro
