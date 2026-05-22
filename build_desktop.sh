#!/bin/bash

set -e

PROJECT_DIR="/home/yuliya/kanban_board"
cd "$PROJECT_DIR"

echo "=========================================="
echo "   Flutter Desktop Build Script"
echo "=========================================="
echo ""

# Создаем временный каталог с линкером
LINKER_DIR=$(mktemp -d)
trap "rm -rf $LINKER_DIR" EXIT

echo "📦 Подготовка..."
echo "  • Копирование gold линкера в $LINKER_DIR"
cp /usr/bin/gold "$LINKER_DIR/ld.lld"
cp /usr/bin/gold "$LINKER_DIR/ld"
chmod +x "$LINKER_DIR/ld.lld" "$LINKER_DIR/ld"

echo "  • Получение зависимостей..."
flutter pub get > /dev/null 2>&1

echo "  • Генерация кода..."
flutter pub run build_runner build > /dev/null 2>&1

echo ""
echo "🔨 Сборка Linux Desktop приложения..."
echo "   (это может занять несколько минут)"
echo ""

# Пытаемся собрать с PATH, указывающим на наши линкеры
if PATH="$LINKER_DIR:$PATH" flutter build linux --release 2>&1 | tail -20; then
    echo ""
    echo "✅ Сборка успешна!"
    echo ""
    echo "🚀 Запуск приложения..."
    exec "$PROJECT_DIR/build/linux/x64/release/bundle/kanban_board"
else
    echo ""
    echo "⚠️  Сборка Linux failed. Используем Android эмулятор..."
    echo ""
    
    # Запускаем эмулятор
    echo "📱 Запуск Android эмулятора..."
    flutter emulators --launch fitness_api_36 > /dev/null 2>&1 &
    EMULATOR_PID=$!
    
    echo "⏳ Ожидание запуска эмулятора (30 сек)..."
    sleep 30
    
    echo ""
    echo "🚀 Запуск приложения на Android..."
    flutter run -d emulator-5554
fi
