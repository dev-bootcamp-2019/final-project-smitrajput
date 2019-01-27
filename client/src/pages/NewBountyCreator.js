import React, { Component } from 'react';
import { Form,Button,Input,Message,Header,Icon } from 'semantic-ui-react'
import web3 from '../../ethereum/web3';
import { Router } from '../routes';

const CreatorFactory = artifacts.require("./CreatorFactory.sol");

class NewBountyCreator extends Component{
	state={
		reward:'',
		title:'',
		description:'',
		errorMessage:'',
		loading:false,
		name:''
	};


	onSubmit = async (event) => {
		event.preventDefault();

		this.setState({loading: true, errorMessage:''});

		const factory = await CreatorFactory.deployed();

		try{
			const accounts = await web3.eth.getAccounts();
			await factory.createBountyCreator(this.state.name, {from: accounts[0]});

			Router.pushRoute('/');
		} catch(err){
			this.setState({ errorMessage: err.message });
		}

		this.setState({loading:false});
	};

	render(){
		return(
			<Layout>
			 <div>
					<div style={{margin:50}}>
						<Header as='h2' icon textAlign='center' color='teal'>
      				<Header.Content>
        				Enter the details
      				</Header.Content>
  				 	 </Header>
  				 	 </div>
  				</div>

			  <Form onSubmit={this.onSubmit} error={!!this.state.errorMessage}>

					<Form.Field>
						<label>Title</label>
						<Input
							value={this.state.title}
							onChange={event => this.setState({ title: event.target.value })}
						/>
					</Form.Field>

					<Form.Field>
						<label>Description</label>
						<Input
							value={this.state.description}
							onChange={event => this.setState({ description: event.target.value })}
						/>
					</Form.Field>

			  	<Form.Field>
			  		<label>Bounty Reward</label>
			  		<Input
			  			label="wei"
			  			labelPosition="right"
			  			value={this.state.reward}
			  			onChange={event => this.setState({ reward: event.target.value })}
			  		/>
			  	</Form.Field>
			  	<Message error header="Oops!" content={this.state.errorMessage} />
			  	<Button loading={this.state.loading} basic color='teal'>Join</Button>
			  </Form>
			 </Layout>
		);
	}
}

export default NewBountyCreator;
