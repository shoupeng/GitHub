Dbox "Model Installation" center, center
	Init Do 
		CloseMenu = 1
		dtext = "This location should match the location used during the installation process."
	EndItem
	Text "Select Application Directory" 0,0

	Text 1,1.5,55 Framed Variable: ApplicationDirectory

	Button "ApplicationDirectory" 57.5,1.2 help:"Directory where the AR TDM Model is installed." icons: "bmp\\buttons|114.bmp", "bmp\\buttons|148.bmp", "bmp\\buttons|182.bmp" Do
		on escape goto skipc2
		ApplicationDirectory = ChooseDirectory("Choose the AR TDM Model Application Directory", )
		skipc2:
		on escape default
	EndItem

	Text 1, 3, 50, 2 Variable: dtext

	Button "Close" 57.5,4 help:"Close the setup dialog box without saving." icons: "bmp\\buttons|440.bmp", "bmp\\buttons|474.bmp", "bmp\\buttons|508.bmp" Cancel Do
		CloseMenu = 1
		Return()
	EndItem 

	Close Do 
		CloseMenu = 1
		Return() 
	EndItem
endDbox

//This is just a test