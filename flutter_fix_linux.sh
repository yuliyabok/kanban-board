#!/bin/bash

# Desktop runner for Linux with linker workaround

set -e

PROJECT_DIR="/home/yuliya/kanban_board"
cd "$PROJECT_DIR"

echo "🔧 Подготовка окружения для Linux Desktop..."

# Шаг 1: Очищаем старую сборку
echo "Cleaning build directories..."
flutter clean

# Шаг 2: Получаем зависимости
echo "Getting dependencies..."
flutter pub get

# Шаг 3: Используем альтернативный подход через docker или системный gold
echo "Preparing linker workaround..."

# Создаем временный скрипт, который переп переопределит линкер для cmake
cat > /tmp/cmake_wrapper.sh << 'WRAPPER'
#!/bin/bash
exec cmake -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++ "$@"
WRAPPER

chmod +x /tmp/cmake_wrapper.sh

# Пытаемся собрать
echo ""
echo "🚀 Building Flutter Linux application..."
export CMAKE_EXECUTABLE=/tmp/cmake_wrapper.sh

flutter build linux --release 2>&1 || {
    echo ""
    echo "❌ Linux Desktop build failed. Trying Android emulator instead..."
    
    echo ""
    echo "📱 Launching Android emulator..."
    flutter emulators --launch fitness_api_36 &
    EMULATOR_PID=$!
    
    sleep 15
    
    echo "Installing and running app on Android..."
    flutter run -d emulator-5554
    
    exit 0
}

echo "✅ Build successful!"
echo ""
echo "🚀 Running Linux application..."

# Запускаем собранное приложение
"$PROJECT_DIR/build/linux/x64/release/bundle/kanban_board"
