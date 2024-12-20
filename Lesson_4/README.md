<h2>ЗАДАЧА:</h2>

Создать объектную модель (классы и методы) для гипотетического приложения управления железнодорожными станциями, которое позволит управлять станциями, принимать и отправлять поезда, показывать информацию о них и т.д.

Требуется написать следующие классы:
  - Класс Station (Станция):
  - Имеет название, которое указывается при ее создании
  - Может принимать поезда (по одному за раз)
  - Может возвращать список всех поездов на станции, находящиеся в текущий момент
  - Может возвращать список поездов на станции по типу (см. ниже): кол-во грузовых, пассажирских
  - Может отправлять поезда (по одному за раз, при этом, поезд удаляется из списка поездов, находящихся на станции).

Класс Route (Маршрут):
  - Имеет начальную и конечную станцию, а также список промежуточных станций. Начальная и конечная станции указываютсся при создании маршрута, а промежуточные могут добавляться между ними.
  - Может добавлять промежуточную станцию в список
  - Может удалять промежуточную станцию из списка
  - Может выводить список всех станций по-порядку от начальной до конечной

Класс Train (Поезд):
  - Имеет номер (произвольная строка) и тип (грузовой, пассажирский) и количество вагонов, эти данные указываются при создании экземпляра класса
  - Может набирать скорость
  - Может возвращать текущую скорость
  - Может тормозить (сбрасывать скорость до нуля)
  - Может возвращать количество вагонов
  - Может прицеплять/отцеплять вагоны (по одному вагону за операцию, метод просто увеличивает или уменьшает количество вагонов). Прицепка/отцепка вагонов может осуществляться только если поезд не движется.
  - Может принимать маршрут следования (объект класса Route). 
  - При назначении маршрута поезду, поезд автоматически помещается на первую станцию в маршруте.
  - Может перемещаться между станциями, указанными в маршруте. Перемещение возможно вперед и назад, но только на 1 станцию за раз.
  - Возвращать предыдущую станцию, текущую, следующую, на основе маршрута
