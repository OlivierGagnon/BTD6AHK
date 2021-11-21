Esc::ExitApp
;Function to get the size of an image
imgSize(img, ByRef width , ByRef height) {
If FileExist(img) {
        GUI, Add, Picture, hwndpic, %img%
        ControlGetPos,,, width, height,, ahk_id %pic%
        Gui, Destroy
    } Else height := width := 0
}

;Find an image and click around the middle of it (some randomness added)
ClickImage(image)
{
    ;X goes sideways, while Y goes up and down
    ;x = width, y = height
    Loop{
        ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 %image%
            if (ErrorLevel = 0)
            {
                Random, sleepRand, -100, 100
                sleepTime := sleepRand + 750
                Sleep, sleepTime
                break
            }
    }
    Random, randX, -2, 2
    Random, randY, -2, 2
    imgSize(image, imageWidth, imageHeight)
    width := %imageWidth%
    height := %imageHeight%
    halfimagewidth := Floor(imageWidth / 2)
    halfimageheight := Floor(imageHeight / 2)
    posX := foundX + halfimagewidth + randX
    posY := foundY + halfimageheight + randY
    MouseClick, left, posX, posY
}
;place a monkey. key, x y and upgrades
PlaceMonkey(key, x, y, up1, up2, up3)
{
    Send %key%
    Random, sleepRand, -50, 50
    sleepTime := sleepRand + 250
    Sleep, sleepTime
    MouseClick, left, x, y
    Sleep 350
    MouseClick, left, x, y
    Sleep 350
    if (up1 > 0)
    {
        While, (up1 != 0)
        {
            Send ","
            Sleep 225
            up1--
        }        
    }
    if (up2 > 0)
    {
        While, (up2 != 0)
        {
            Send .
            Sleep 225
            up2--
        }
    }
    if (up3 > 0)
    {
        While, (up3 != 0)
        {
            Send /
            Sleep 225
            up3--
        }
    }
}

SellMonkeyAt(x, y)
{
    Sleep 225
    MouseClick, left, x, y
    Sleep 225
    Send {Backspace}
    ;ClickImage("sell.png")
}

AimMortar(bombX, bombY)
{
    MouseClick, left, 1212, 346 ;dirty. aim mortar
    Sleep 400
    MouseClick, left, bombX, bombY
}

MonitorLevelUp()
{
    Loop{
        ;loop here. try to find either a levelup, or the end of the level screen
        ;if a levelup is found, click twice.
        ;if end screen is found, exit loop
        ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 levelup.png
        if (ErrorLevel = 0)
        {
            MouseClick, left, 698, 508
            Sleep 500
            MouseClick, left, 698, 508
            Sleep 225
            break
        }
        ImageSearch, FoundX, FoundY, 0, 0, A_ScreenWidth, A_ScreenHeight, *10 victory.png
        if (ErrorLevel = 0)
        {
            break
        }
    }
}
;;;;;;;;;;;;;;;;;;;;;;;;;;
F9::
Loop
{
    CoordMode, Mouse, Window
    if WinExist("BloonsTD6")
    WinActivate
    ClickImage("01-play.png")
    ClickImage("02-expert.png")
    ClickImage("03-next.png")
    ClickImage("04-map.png")
    ClickImage("05-easy.png")
    ClickImage("06-deflation1.png")
    ClickImage("07-ok.png")
    Sleep 500
    Click 680, 632
    Sleep 2000 ; wait a bit before placing monkeys
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;; EDIT BELOW      ;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    PlaceMonkey("k", 594, 317, 0, 0, 2)
    PlaceMonkey("k", 695, 301, 0, 0, 2)
    PlaceMonkey("u", 613, 399, 0, 0, 0)
    PlaceMonkey("s", 695, 396, 2, 0, 3) 
    PlaceMonkey("n", 637, 203, 0, 2, 3)
    Sleep 300
    AimMortar(641, 493)
    SellMonkeyAt(594, 317)
    SellMonkeyAt(695, 301)
    PlaceMonkey("q", 420, 354, 0, 2, 3)
    PlaceMonkey("q", 422, 655, 0, 2, 2)
    PlaceMonkey("x", 925, 387, 2, 0, 2)

    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    ;;;;;;;;;; EDIT ABOVE      ;;;;;;;;;
    ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    Sleep 500
    Send {Space}
    Sleep 225
    Send {Space}
    Click 680, 632
    ; loop to monitor either a levelup, or the level is finished
    MonitorLevelUp()
    ClickImage("08-next.png")
    ClickImage("09-home.png")
}