# author Sergiy Voronov 
#dribbble.com/mamezito
#twitter.com/mamezito

Utils.insertCSS('@import url(https://fonts.googleapis.com/icon?family=Material+Icons); @import url(http://fonts.googleapis.com/css?family=Roboto);  html, body, input, .framerLayer{font-family: "Roboto Light", sans-serif!important; font-size:80px; color:#fff; text-align:center;}')

back=new BackgroundLayer
	backgroundColor: "#fff"
result=""
results=new Layer
	width:Screen.width
	height:Screen.height/3
	backgroundColor: "#fff"
	shadowY : 10
	shadowBlur : 40
	shadowColor : "rgba(0,0,0,0.2)"
	html:result

screen=new Layer
	backgroundColor: "null"
	superLayer: results
	width:Screen.width*0.9
	y:results.height/2
	opacity:1
value=new Layer
	backgroundColor: "null"
	y:results.height/4*3
	superLayer: results
	width:Screen.width*0.9
	originX:1
	opacity:0.8
	scale:0.6
value.style=
	"text-align": "right", "font-size": "180px", "color": "#757575"
screen.style=
	"text-align": "right", "font-size": "180px", "color": "#757575"
screen.states.add
	enter:
		y:-100
		opacity:0
value.states.add
	enter:
		y:results.height/2
		scale:1
		opacity:1
	

numpad= new Layer
	width:Screen.width
	height:Screen.height-results.height
	backgroundColor:"#3a3a3a"
	y:results.height
actionsBack=new Layer
	backgroundColor: "#636363"
	y:0
	x:Screen.width/4*3
	width:Screen.width/4
	height:Screen.height-results.height
	superLayer: numpad
	clip:true
results.bringToFront()
numberButtons=[["7","8","9"], ["4","5","6"],["1","2","3"],[".","0","="]]
actionButtons=["C","+","-","/","*"]
buttons=[]
for y in [0..3]
	for x in [0..2]
		button= new Layer
			name:numberButtons[y][x]
			width:Screen.width/4
			height:numpad.height/4
			x:x*Screen.width/4
			y:y*numpad.height/4
			backgroundColor: "null"
			superLayer: numpad
		button.value=numberButtons[y][x]
		Utils.labelLayer(button,numberButtons[y][x])
		button.style.fontSize = "80px"
		buttons.push(button)
for y in	[0..4]
	button=new Layer
		name:actionButtons[y]
		width:Screen.width/4
		height:numpad.height/5
		x:0
		y:y*numpad.height/5
		backgroundColor: "null"
		superLayer: actionsBack
	Utils.labelLayer(button,actionButtons[y])
	button.style.fontSize = "80px"
	buttons.push(button)
actionsBack.bringToFront()
for button in buttons
	circle=new Layer
		borderRadius: button.width
		width:button.width*1.3
		height:button.width*1.3
		superLayer: button
		backgroundColor: "#fff"
		opacity:0
	circle2=circle.copy()
	circle2.superLayer=button
	circle.center()
	circle2.center()
	circle2.scale=0.1
	circle2.opacity=0

	button.onTouchEnd ->
		this.children[0].animateStop()
		this.children[1].animateStop()
		this.children[0].animate
			properties:
				opacity:0
			time:0.3
		this.children[1].opacity=0
		this.children[1].scale=0.1
	button.onTouchStart ->
		this.children[0].animate
			properties:
				opacity:0.05
			time:0.5
		this.children[1].animate
			properties:
				opacity:0.05
				scale:1
			time:0.4
		if this.name=="="
			result=eval (eval screen.html).toFixed(5)
			value.states.switch("enter", time: 0.3, curve: "ease")
			screen.states.switch("enter", time: 0.3, curve: "ease")
			Utils.delay 1, ->
				value.states.switchInstant("default")
				screen.states.switchInstant("default")
				screen.html=result

		else if this.name=="C"
			result=""
		else if this.name=="/"
			result+='/'
		else if this.name=="*"
			result+='*'
		else if this.name=="."
			if parseInt(eval screen.html) == (eval screen.html)
				result+='.'
			else
		else
			if result==0
				result=this.name
			else
				result+=this.name
		screen.html=result
		if typeof (eval screen.html) isnt 'undefined'
# 			val=eval screen.html
# 			if parseInt(val) != val
# 				val=val.toFixed(5)
			value.html=eval (eval screen.html).toFixed(5)
		else
			value.html=""
