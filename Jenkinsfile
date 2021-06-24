pipeline {
    agent { dockerfile true }

    stages {
        stage('Testing') {
            steps {
                echo 'Builded container test'
            }
        }
        stage('Delivery') {
            steps {
                echo 'Переносим код в рабочую среду или создаем артефакт'
            }
        }
    }
}
