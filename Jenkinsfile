currentBuild.displayName = "Final_Demo # "+currentBuild.number

 def registryProjet='deekshithsn/devops-training'

   def getDockerTag(){
        def tag = sh script: 'git rev-parse HEAD', returnStdout: true
        return tag
        }
        

pipeline{
        agent any  
        environment{
	    Docker_tag = getDockerTag()
        }
        
        stages{


              stage('Quality Gate Statuc Check'){

               agent {
                docker {
                image 'maven'
                args '-v $HOME/.m2:/root/.m2'
                }
            }
                  steps{
                      script{
                      withSonarQubeEnv('sonar_server') { 
                      sh "mvn sonar:sonar"
                       }
                   
		    sh "mvn clean install"
                  }
                }  
              }


                    def IMAGE="deekshithsn/devops-training:$docker_tag"
              stage('build')
                {
              steps{
                  script{
		 sh 'cp -r /var/jenkins_home/workspace/maven-ansible-sonar-k8s@2/target .'
			  
		 def img = stage('Build') {
			docker.build("$IMAGE",  '.')
		 }	  
                  
		 docker.withRegistry('http://192.168.32.131:8888', 'nexus') {
				    
			img.push()  
				
		 }
                       }
                    }
                 }
		 
		stage('ansible playbook'){
			steps{
			 	
				    ansiblePlaybook become: true, installation: 'ansible', inventory: 'hosts', playbook: 'ansible.yaml'
				
			}
		}
		
	
		
               }
	       
	       
	       
	      
    
}
