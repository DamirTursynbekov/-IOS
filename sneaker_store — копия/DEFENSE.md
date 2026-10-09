# Защита — 3–5 минут

## Pitch — 45 секунд
Hello! My project is called Sneaker Store. It is a shopping application for students and young adults. It helps users browse sneakers, compare prices, save favorites and select a size. This is the first UI milestone. The catalogue contains demo data, and the app does not process real payments.

## Live demo — 2 минуты
Открой Discover, найди Velocity, очисти поиск, выбери Running и верни All:
This is the discovery screen. Product cards display images, prices and ratings. Search and category filters help users find a pair. The interface updates with setState.

Нажми закладку и открой Favorites:
The bookmark saves a product. The favorites screen displays my saved pairs.

Открой товар, выбери размер 42 и нажми Add to Cart:
The detail screen uses Stack for the image and bookmark overlay. Tags and sizes use Wrap, so they move to another line on smaller screens. The bottom action bar stays visible while the content scrolls. I must select a size before adding the product.

Назад → Cart → плюс:
The cart calculates the total from price and quantity. The same product and size share one entry. A different size creates a separate entry. My selections remain when I navigate back.

## Code review — 1 минута
Покажи папки lib:
I separated screens, reusable widgets, models and data. ProductCard is reusable. Product contains catalogue information. CartItem stores the selected size and quantity.

Открой store_screen.dart:
StoreScreen is a StatefulWidget. It owns favorites and cart state. Child screens receive data and callbacks. setState tells Flutter to rebuild the interface after changes.

Открой detail_screen.dart:
LayoutBuilder checks available width. On wide screens, the image and information are side by side. On narrow screens, they appear vertically. Expanded controls width inside Row. Wrap and scrolling help the content fit.

Только после запуска проверок:
I tested the app on small and large screens and checked for RenderFlex overflow.

Next, I plan to add a REST API, a database and BLoC architecture.

## Вопросы и ответы
**Stack?** Виджеты слоями; здесь закладка поверх фотографии.

**Row / Column?** Горизонтальное / вертикальное размещение детей.

**Expanded?** Занимает оставшееся доступное место внутри Row/Column. Нижняя кнопка получает всю доступную ширину.

**Wrap?** Переносит элементы на новую строку при недостатке ширины.

**StatefulWidget?** Виджет с изменяемым состоянием: размер, закладка, вкладка, корзина.

**setState?** Изменяем состояние и уведомляем Flutter о необходимости перестроения. В базу данные он не записывает.

**Почему корзина сохраняется при возврате?** Она хранится в StoreScreen; Navigator.push открывает детали поверх него, не уничтожая главный экран.

**Navigator.pop?** Закрывает текущий маршрут и возвращает предыдущий.

**Как передаётся товар?** Полный объект Product передаётся через конструктор DetailScreen.

**Как считается сумма?** Цена × количество для строки; fold суммирует строки.

**Зачем callbacks?** Детали сообщают главному экрану о добавлении в корзину или изменении закладки.

**Почему не BLoC?** На первом этапе преподаватель требует StatefulWidget/setState; BLoC добавляется позже.

**Есть оплата/база?** Пока нет. Локальный интерфейсный MVP. После полного перезапуска состояние очищается.

**Как проверить адаптивность?** flutter test плюс ручная проверка на устройствах. Включены размеры 320×568, 390×844, 1024×768; для деталей — ещё шрифт 1.5×. Говори «проверено» только после реального запуска.
