# Animal Farm Smart Contracts 

![Node.js](https://img.shields.io/badge/Node.js-18-339933?style=for-the-badge&logo=node.js&logoColor=white) ![Hardhat](https://img.shields.io/badge/Hardhat-latest-FFF100?style=for-the-badge&logo=hardhat&logoColor=black) ![Solidity](https://img.shields.io/badge/Solidity-0.8.23-363636?style=for-the-badge&logo=solidity&logoColor=white) ![Ethereum](https://img.shields.io/badge/Ethereum-Sepolia-3C3C3D?style=for-the-badge&logo=ethereum&logoColor=white)

## Автор

**Розробник:** Сергій Щербаков
**Email:** sergiyscherbakov@ukr.net
**Telegram:** @s_help_2010

### 💰 Підтримати розробку
Задонатити на каву USDT (BINANCE SMART CHAIN):
**`0xDFD0A23d2FEd7c1ab8A0F9A4a1F8386832B6f95A`**

---

## Опис проекту

Hardhat проект з реалізацією системи смарт-контрактів "Тваринна ферма" на блокчейні Ethereum. Проект демонструє використання інтерфейсів, абстрактних контрактів, множинного наслідування та деплой у тестову мережу Sepolia.

## Архітектура контрактів

### Ієрархія класів

```
Living (Interface)
    ↓
Animal (Abstract)
    ↓
    ├── Herbivore (Abstract) → Cow, Horse
    ├── Carnivore (Abstract) → Wolf
    └── Omnivore (Abstract) → Dog

HasName (Base Contract) → успадковується всіма тваринами

Farmer (Main Contract) → взаємодіє з тваринами
```

### Контракти

#### 1. Living (Interface)
Базовий інтерфейс для всіх живих істот.
- `eat(string memory food)` - функція приймання їжі

#### 2. HasName (Base Contract)
Базовий контракт для зберігання імені.
- `_name` - внутрішня змінна для зберігання імені

#### 3. Animal (Abstract Contract)
Абстрактний контракт тварини з базовим функціоналом.
- `eat(string memory food)` - повертає "Animal eats {food}"
- `sleep()` - повертає "Z-z-z-z-z...."
- `speak()` - віртуальна функція для звуків тварини

#### 4. Herbivore (Abstract Contract)
Травоїдна тварина - їсть лише рослинну їжу.
- Модифікатор `eatOnlyPlant` - перевіряє, що їжа це "plant"
- Константа `PLANT = "plant"`

#### 5. Carnivore (Abstract Contract)
М'ясоїдна тварина - їсть лише м'ясо.
- Модифікатор `eatOnlyMeat` - перевіряє, що їжа це "meat"
- Константа `MEAT = "meat"`

#### 6. Omnivore (Abstract Contract)
Всеїдна тварина - їсть м'ясо або рослинну їжу.
- Модифікатор `eatMeatOrPlant` - перевіряє, що їжа це "meat" або "plant"

#### 7. Cow (Concrete Contract)
Корова - травоїдна тварина.
- `speak()` - повертає "Mooo"

#### 8. Horse (Concrete Contract)
Кінь - травоїдна тварина.
- `speak()` - повертає "Igogo"
- `name()` - повертає ім'я коня

#### 9. Wolf (Concrete Contract)
Вовк - м'ясоїдна тварина.
- `speak()` - повертає "Howl"

#### 10. Dog (Concrete Contract)
Собака - всеїдна тварина.
- `speak()` - повертає "Woof"
- `name()` - повертає ім'я собаки

#### 11. Farmer (Main Contract)
Фермер - керує тваринами на фермі.
- `call(address animal)` - викликає тварину (отримує звук)
- `feed(address animal, string memory food)` - годує тварину
- `isContract(address _addr)` - перевіряє, чи адреса є контрактом

## Структура проекту

```
animal-farm-hardhat/
├── contracts/
│   └── 9-2.sol              # Всі смарт-контракти тварин
├── scripts/
│   ├── 14.js                # Основний скрипт деплою та тестування
│   └── deploy.js            # Скрипт деплою Lock контракту
├── test/
│   ├── 14.js                # Тести для Animal Farm
│   └── Lock.js              # Тести для Lock контракту
├── ДЗ-14.txt                # Опис домашнього завдання
├── ДЗ-14.docx               # Детальне завдання
└── README.md                # Цей файл
```

## Встановлення та налаштування

### Передумови
- Node.js >= 16.0.0
- npm або yarn
- MetaMask або інший Web3 гаманець
- Sepolia ETH (з крана https://sepoliafaucet.com/)

### Крок 1: Клонування репозиторію
```bash
git clone https://github.com/sergiyscherbakov/animal-farm-hardhat.git
cd animal-farm-hardhat
```

### Крок 2: Встановлення залежностей
```bash
npm install
```

Це встановить:
- Hardhat
- Ethers.js
- Chai (для тестів)
- Hardhat plugins

### Крок 3: Налаштування hardhat.config.js

Створіть файл `hardhat.config.js`:

```javascript
require("@nomicfoundation/hardhat-toolbox");

const SEPOLIA_RPC_URL = "https://eth-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_KEY";
const PRIVATE_KEY = "your_private_key_here";

module.exports = {
  solidity: "0.8.23",
  networks: {
    sepolia: {
      url: SEPOLIA_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 11155111
    }
  }
};
```

### Крок 4: Налаштування змінних оточення

Створіть файл `.env`:
```
SEPOLIA_RPC_URL=https://eth-sepolia.g.alchemy.com/v2/YOUR_ALCHEMY_KEY
PRIVATE_KEY=your_private_key_here
ETHERSCAN_API_KEY=your_etherscan_api_key
```

**ВАЖЛИВО:** Ніколи не комітьте приватні ключі в Git!

## Запуск проекту

### Компіляція контрактів

```bash
npx hardhat compile
```

Очікуваний результат:
```
Compiled 1 Solidity file successfully
```

### Запуск тестів локально

```bash
npx hardhat test
```

Очікуваний результат:
```
  Animal Farm
    ✔ should make the cow say 'Mooo'
    ✔ should make the horse say 'Igogo'
    ✔ should not allow the wolf to eat plant
    ✔ should allow the wolf to eat meat

  4 passing
```

### Запуск тестів конкретного файлу

```bash
npx hardhat test test/14.js
```

## Деплой у Sepolia

### Метод 1: Через локальний скрипт

```bash
npx hardhat run scripts/14.js --network sepolia
```

### Метод 2: Покрокове тестування

```bash
# 1. Запустити Hardhat console для Sepolia
npx hardhat console --network sepolia

# 2. В консолі виконати:
const script = require('./scripts/14.js');
```

## Очікувані результати виконання

### Деплой контрактів

```
Deploying contracts with the account: 0x...
Cow deployed to: 0x...
Horse deployed to: 0x...
Wolf deployed to: 0x...
Farmer deployed to: 0x...
```

### Виклик методу call()

```
Calling speak on Cow and Horse:
Mooo
Igogo
```

### Виклик методу feed()

```
Feeding Wolf with plant and meat:
Error: Wolf can't eat plant
Animal eats meat
```

## Детальні інструкції з тестування

### Тест 1: Деплой контрактів

1. Переконайтесь, що у вас є Sepolia ETH
2. Запустіть скрипт:
   ```bash
   npx hardhat run scripts/14.js --network sepolia
   ```
3. Дочекайтесь деплою всіх 4 контрактів
4. Збережіть адреси контрактів з консолі

### Тест 2: Виклик Cow і Horse

**Очікувана послідовність:**
1. Фермер викликає корову: `farmer.call(cow.target)`
   - Результат: `"Mooo"`
2. Фермер викликає коня: `farmer.call(horse.target)`
   - Результат: `"Igogo"`

### Тест 3: Годування Wolf

**Очікувана послідовність:**

1. **Спроба нагодувати Wolf рослинною їжею:**
   ```javascript
   farmer.feed(wolf.target, "plant")
   ```
   - Очікується: Помилка "Can only eat meat"
   - В консолі: "Error: Wolf can't eat plant"

2. **Годування Wolf м'ясом:**
   ```javascript
   farmer.feed(wolf.target, "meat")
   ```
   - Очікується: "Animal eats meat"
   - В консолі: "Animal eats meat"

## Таблиця результатів тестування

| Тест | Метод | Параметри | Очікуваний результат |
|------|-------|-----------|---------------------|
| 1 | Деплой Cow | "Bessie" | Адреса контракту Cow |
| 2 | Деплой Horse | "Pegasus" | Адреса контракту Horse |
| 3 | Деплой Wolf | "Grey Wind" | Адреса контракту Wolf |
| 4 | Деплой Farmer | - | Адреса контракту Farmer |
| 5 | farmer.call() | cow.target | "Mooo" |
| 6 | farmer.call() | horse.target | "Igogo" |
| 7 | farmer.feed() | wolf.target, "plant" | Помилка: "Can only eat meat" |
| 8 | farmer.feed() | wolf.target, "meat" | "Animal eats meat" |

## Приклади імен для тварин

- **Cow:** "Bessie", "Daisy", "Molly"
- **Horse:** "Pegasus", "Thunder", "Spirit"
- **Wolf:** "Grey Wind", "Ghost", "Nymeria"
- **Dog:** "Rex", "Buddy", "Max"

## Технічні особливості

### Gas Optimization
- Використання `pure` функцій для speak() та eat() де можливо
- Використання `view` для call() та isContract()
- Константи для типів їжі (PLANT, MEAT)

### Security Features
- Модифікатори для контролю типу їжі
- Перевірка через require() у всіх критичних функціях
- Перевірка чи адреса є контрактом в isContract()

### Assembly Usage
```solidity
function isContract(address _addr) private view returns (bool) {
    uint32 size;
    assembly {
        size := extcodesize(_addr)
    }
    return (size > 0);
}
```
Використання inline assembly для ефективної перевірки наявності коду за адресою.

## Можливі помилки та вирішення

### Помилка: "Cannot find module 'hardhat'"
**Рішення:**
```bash
npm install --save-dev hardhat
```

### Помилка: "insufficient funds for gas"
**Рішення:**
- Отримайте Sepolia ETH з крана
- Перевірте баланс: https://sepolia.etherscan.io/

### Помилка: "Can only eat meat" при годуванні Wolf
**Рішення:**
- Це очікувана поведінка при спробі нагодувати Wolf рослинною їжею
- Використайте "meat" замість "plant"

### Помилка: "nonce too high"
**Рішення:**
```bash
npx hardhat clean
# Перезапустіть скрипт
```

### Помилка при компіляції: "Source file requires different compiler version"
**Рішення:**
- Перевірте версію в hardhat.config.js: `solidity: "0.8.23"`
- Перекомпілюйте: `npx hardhat compile`

## Корисні команди Hardhat

```bash
# Компіляція контрактів
npx hardhat compile

# Запуск всіх тестів
npx hardhat test

# Запуск конкретного тесту
npx hardhat test test/14.js

# Очистка артефактів
npx hardhat clean

# Запуск локального Hardhat node
npx hardhat node

# Деплой у локальну мережу
npx hardhat run scripts/14.js --network localhost

# Деплой у Sepolia
npx hardhat run scripts/14.js --network sepolia

# Відкрити Hardhat console
npx hardhat console --network sepolia

# Перевірка контракту на Etherscan
npx hardhat verify --network sepolia DEPLOYED_CONTRACT_ADDRESS
```

## Корисні посилання

### Документація
- [Hardhat Documentation](https://hardhat.org/docs)
- [Ethers.js Documentation](https://docs.ethers.org/)
- [Solidity Documentation](https://docs.soliditylang.org/)
- [Chai Assertions](https://www.chaijs.com/)

### Інструменти
- [Sepolia Faucet](https://sepoliafaucet.com/)
- [Sepolia Etherscan](https://sepolia.etherscan.io/)
- [Alchemy](https://www.alchemy.com/)
- [Infura](https://infura.io/)

### Концепції
- [Solidity Inheritance](https://docs.soliditylang.org/en/latest/contracts.html#inheritance)
- [Abstract Contracts](https://docs.soliditylang.org/en/latest/contracts.html#abstract-contracts)
- [Interfaces](https://docs.soliditylang.org/en/latest/contracts.html#interfaces)
- [Function Modifiers](https://docs.soliditylang.org/en/latest/contracts.html#function-modifiers)

## Best Practices

1. **Завжди тестуйте локально** перед деплоєм у Sepolia
2. **Використовуйте .env** для приватних ключів
3. **Додайте .env до .gitignore**
4. **Верифікуйте контракти** на Etherscan після деплою
5. **Документуйте код** за допомогою NatSpec
6. **Використовуйте модифікатори** для повторюваної логіки
7. **Пишіть юніт-тести** для всіх функцій
8. **Перевіряйте gas costs** перед деплоєм у mainnet

## Розширення проекту

### Додаткові функції для реалізації:
1. **Inventory система** - фермер може зберігати їжу
2. **Health система** - тварини мають здоров'я
3. **Breeding система** - розведення тварин
4. **Events** - події для кожної дії
5. **Ownership** - кожна тварина має власника
6. **Marketplace** - купівля-продаж тварин

## Навчальні цілі

Цей проект демонструє:
- ✅ Множинне наслідування в Solidity
- ✅ Використання абстрактних контрактів
- ✅ Імплементацію інтерфейсів
- ✅ Модифікатори функцій
- ✅ Взаємодію між контрактами
- ✅ Деплой у публічну тестову мережу
- ✅ Написання тестів з Hardhat
- ✅ Використання Ethers.js
- ✅ Assembly для оптимізації

## Ліцензія

MIT

---

**Примітка:** Цей проект створено в навчальних цілях для демонстрації роботи з Hardhat та деплою смарт-контрактів у Ethereum Sepolia testnet.
