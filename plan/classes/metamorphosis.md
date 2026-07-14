# fundamental

## int ->
### -> str
- [ ] `__tostring`: число в строку
### -> lts
- [ ] `__totable`:
### -> bin
- [ ] `__tofunction`:
### -> ins
- [ ] `__toinstance`:
### -> vector2
- [ ] `__tovector2`: по половине на каждую координату
### -> vector3
- [ ] `__tovector3`: по половине на каждую координату
### -> cframe
- [ ] `__tocframe`: по половине на каждую координату и нулевой лук

## str ->
### -> int
- [ ] `__tonumber`:
### -> lts
- [ ] `__totable`:
### -> bin
- [ ] `__tofunction`:
### -> ins
- [ ] `__toinstance`:
### -> vector2
- [ ] `__tovector2`:
### -> vector3
- [ ] `__tovector3`:
### -> cframe
- [ ] `__tocframe`:

## lts ->
### -> int
- [ ] `__tonumber`: колво потомков
### -> bin
- [ ] `__tofunction`: функция которая собирает копию **lts**
	- [ ] должна низводить сложные элементы до базовых дабы возсоздание было максимально чистое
### -> ins
- [ ] `__toinstance`:
### -> vector2
- [ ] `__tovector2`:
### -> vector3
- [ ] `__tovector3`:
### -> cframe
- [ ] `__tocframe`:

# normal
## ins ->
### -> int
- [ ] `__tonumber`: id
### -> lts
- [ ] `__totable`: все не дефолтные параметры
### -> bin
- [ ] `__tofunction`: бинарник на воссоздание копии
### -> vector2
- [ ] `__tovector2`: .position(x,y)
### -> vector3
- [ ] `__tovector3`: .position
### -> cframe
- [ ] `__tocframe`: .cframe

# custom
## plr ->
### -> int
- [ ] `__tonumber`:
### -> lts
- [ ] `__totable`:
### -> bin
- [ ] `__tofunction`:
### -> ins
- [ ] `__toinstance`:
### -> vector2
- [ ] `__tovector2`:
### -> vector3
- [ ] `__tovector3`:
### -> cframe
- [ ] `__tocframe`:

## json ->
### -> int
- [ ] `__tonumber`: вес данных
### -> lts
- [ ] `__totable`: 
### -> bin
- [ ] `__tofunction`:
### -> ins
- [ ] `__toinstance`: создание [[ins]] как из [[lts]]
### -> vector2
- [ ] `__tovector2`: 
### -> vector3
- [ ] `__tovector3`:
### -> cframe
- [ ] `__tocframe`: 
