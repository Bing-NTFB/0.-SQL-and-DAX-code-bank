--Charles's list
FBC Storage Requirement Code = 'REF', ''
Oranges
	FBC Product Type Code
		='FRT-CITRUS'
		='FRT-TREE'
		=NULL
	
Apples
	FBC Product Type Code
		='FRT-TREE'
		=!'FRT-EXOTIC'
	Description
		NOT IN ('SLICED', 'SLICES')
	
Onions
	FBC Product Type Code
		='VEG-BULB'
	Description
		NOT IN ('SLICED', 'GREEN')
		
Carrots
	FBC Product Type Code
		= 'VEG-ROOTS'
		
Cabbage
	FBC Product Type Code 
		= 'VEG-LEAFY'
	Description
		NOT IN ('SHREDDED')
		
Potatoes
	FBC Product Type Code
		= 'VEG-ROOTS'
		= 'VEG-TUBER'
	Description
		NOT IN ('SWEET')
		
Sweet Potatoes
	FBC Product Type Code
		= 'VEG-ROOTS'
		= 'VEG-TUBER'
	Description
		IN ('SWEET')