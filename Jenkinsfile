pipeline {
    agent { dockerfile true }

    stages {
        stage('Подготовка') {
            steps {
                sh "php -v"
            }
        }
        stage('Сборка') {
            steps {
                echo 'Выполняем команды для сборки'
            }
        }
        stage('Тестирование') {
            steps {
                echo 'Тестируем нашу сборку'
            }
        }
        stage('Развертывание') {
            steps {
                echo 'Переносим код в рабочую среду или создаем артефакт'
            }
        }
    }
}
