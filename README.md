# Black-Jack

Блэкджек (Blackjack) &mdash; популярная игра, известная как “двадцать одно” или “очко”. Эта азартная игра присутствует во всех казино мира, и ее преимущество, что вероятность выигрыша игрока велика.

## Установка игры

Чтобы запустить игру, на вашем компьютере должен быть язык Ruby. Желательно 2.7.2 версии или выше. Для установки на MacOs или Linux можно воспользоваться менеджером версий [RVM](https://rvm.io/), для Windows &mdash; [RubyInstaller](https://rubyinstaller.org/).

После того, как язык Ruby установлен, необходимо клонировать репозиторий себе на локальную машину, перейти в проект и запустить в консоли файл main.rb.

```ruby
git clone git@github.com:Maks-well-88/Black-Jack.git
cd Black-Jack/
ruby main.rb
```

## Правила игры

В начале игры дилер спросит ваше имя, его нужно написать в консоли. На старте у обоих по 100$. Ставка всегда стандартная &mdash; 10$ с каждого. Далее дилер сдает себе и игроку по 2 карты, игрок видит только свои карты и общую сумму очков. 
Игрок оценивает ситуацию и может пропустить ход (нажать цифру 1 и нажать enter), добавить себе новую карту из колоды (нажать цифру 2  и нажать enter), вскрыть карты (нажать цифру 3  и нажать enter).
Чтобы выиграть у дилера, нужно при вскрытии карт иметь больше очков, чем у него и при этом не привысить в сумме 21.

## Советы на старте

1. Если вы видите, что у вас 19, 20 или 21 очко после раздачи, то лучше сразу открыть карты. 
2. Если вы возьмете карту, то дилер сначала добавит себе 1 штуку и потом вскроет карты у себя и у игрока для подсчета очков.
3. Если после раздачи у вас мало очков, то вы можете пропустить ход, чтобы дилер, возяв карту, перебрал с очками.
4. Если вы пропустите ход в пользу дилера, не ожидайте, что он возьмет карту. Он может тоже пропустить ход.
