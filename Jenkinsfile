        
pipeline{
       
              


              
		 
		stage('ansible playbook'){
			steps{ 
				script{
				    sh '''final_tag=$(echo $Docker_tag | tr -d ' ')
				     echo ${final_tag}test
				     sed -i "s/docker_tag/$final_tag/g"  deployment.yaml
				     '''
			 	
				    ansiblePlaybook become: true, installation: 'ansible', inventory: 'hosts', playbook: 'ansible.yaml'
				
			}
			}}
		
	
		
               }
	       
	       
	       
	      
    
}
