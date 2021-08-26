!classDefinition: #PortfoliosTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #PortfoliosTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!PortfoliosTest methodsFor: 'transaction is registered test' stamp: 'Nacho 7/7/2021 03:09:31'!
test02TransactionIsNotRegisteredOnEmptyPortfolio

	|aPortfolio account1 aTransaction|
	
	aPortfolio := Portfolio new.
	
	account1 := ReceptiveAccount new.
	aTransaction := Deposit register: 50*peso on: account1.
	
	self deny: (aPortfolio hasRegistered: aTransaction).! !

!PortfoliosTest methodsFor: 'transaction is registered test' stamp: 'Nacho 7/8/2021 15:49:45'!
test05TransactionIsRegisteredOnAPortfolioWithOneAccount

	|aPortfolio account aTransaction|
	
	account := ReceptiveAccount new.
	aTransaction := Deposit register: 50*peso on: account.
	
	aPortfolio := self portfolioContainingAccounts: (OrderedCollection  with: account ).
	
	self assert: (aPortfolio hasRegistered: aTransaction).! !

!PortfoliosTest methodsFor: 'transaction is registered test' stamp: 'Nacho 7/8/2021 15:49:45'!
test08TransactionsAreRegisteredOnAPortfolioWithMultipleAccounts

	|aPortfolio account1 account2 transaction1 transaction2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	transaction1 := Deposit register: 50*peso on: account1.
	transaction2 := Deposit register: 50*peso on: account2.
	
	aPortfolio := self portfolioContainingAccounts: (OrderedCollection with: account1 with: account2).
	
	self assert: (aPortfolio hasRegistered: transaction1 ).
	self assert: (aPortfolio hasRegistered: transaction2 ).! !

!PortfoliosTest methodsFor: 'transaction is registered test' stamp: 'Nacho 7/8/2021 15:49:45'!
test11TransactionIsRegisteredOnAPortfolioContainingAnotherPortfolio

	|mainPortfolio secondaryPortfolio account aTransaction|
	
	account := ReceptiveAccount new.
	aTransaction := Deposit register: 50*peso on: account.
	
	secondaryPortfolio := self portfolioContainingAccounts: (OrderedCollection with: account).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio).
	
	self assert: (mainPortfolio hasRegistered: aTransaction).! !

!PortfoliosTest methodsFor: 'transaction is registered test' stamp: 'Nacho 7/8/2021 15:49:45'!
test14TransactionIsRegisteredOnAPortfolioContainingMultiplePortfolios

	|mainPortfolio secondaryPortfolio1 secondaryPortfolio2 account aTransaction|
	
	account := ReceptiveAccount new.
	aTransaction := Deposit register: 50*peso on: account.
	
	secondaryPortfolio1 := self portfolioContainingAccounts: (OrderedCollection with: account).
	secondaryPortfolio2 := self portfolioContainingAccounts: (OrderedCollection new).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio1 with: secondaryPortfolio2).
	
	self assert: (mainPortfolio hasRegistered: aTransaction).! !

!PortfoliosTest methodsFor: 'transaction is registered test' stamp: 'Nacho 7/8/2021 15:49:45'!
test17TransactionIsRegisteredOnPortfolioContainingAnotherPortfolioAndOneAccount

	|mainPortfolio secondaryPortfolio secondaryPortfolioAccount account transaction1 transaction2|
	
	secondaryPortfolioAccount := ReceptiveAccount new.
	account := ReceptiveAccount new.
	transaction1 := Deposit register: 50*peso on: secondaryPortfolioAccount.
	transaction2 :=Deposit register: 50*peso on: account.
	
	secondaryPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolioAccount ).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio with: account).
	
	self assert: (mainPortfolio hasRegistered: transaction1).
	self assert: (mainPortfolio hasRegistered: transaction2).! !


!PortfoliosTest methodsFor: 'transactions test' stamp: 'Nacho 7/7/2021 03:09:52'!
test03AnEmptyPortfolioHasNoTransactions

	|aPortfolio |
	aPortfolio := Portfolio new.
	
	self assert: (aPortfolio transactions) isEmpty.! !

!PortfoliosTest methodsFor: 'transactions test' stamp: 'Nacho 7/8/2021 15:49:45'!
test06PortfolioWithOneAccountKnowsItsTransactions

	|aPortfolio account transaction1 transaction2|

	account := ReceptiveAccount new.
	transaction1 := Deposit register: 50 * peso on: account.
	transaction2 := Withdraw register: 50 * peso on: account.
	
	aPortfolio := self portfolioContainingAccounts: (OrderedCollection with: account).
	
	self assert: (aPortfolio transactions) equals: (OrderedCollection with: transaction1 with: transaction2) .! !

!PortfoliosTest methodsFor: 'transactions test' stamp: 'Nacho 7/8/2021 15:49:45'!
test09PortfolioWithMultipleAccountsKnowsItsTransactions

	|aPortfolio account1 account2 transaction1 transaction2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	transaction1 := Deposit register: 50 * peso on: account1.
	transaction2 := Deposit register: 50 * peso on: account2.
	
	aPortfolio := self portfolioContainingAccounts: (OrderedCollection with: account1 with: account2).
	
	self assert: (aPortfolio transactions) equals: (OrderedCollection with: transaction1 with: transaction2) .! !

!PortfoliosTest methodsFor: 'transactions test' stamp: 'Nacho 7/8/2021 15:49:45'!
test12APortfolioContainingAnotherPortfolioKnowsItsTransactions

	|mainPortfolio secondaryPortfolio account aTransaction|
	
	account := ReceptiveAccount new.
	aTransaction := Deposit register: 50*peso on: account.
	
	secondaryPortfolio := self portfolioContainingAccounts: (OrderedCollection with: account).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio).
	
	self assert: mainPortfolio transactions equals: (OrderedCollection with: aTransaction).! !

!PortfoliosTest methodsFor: 'transactions test' stamp: 'Nacho 7/8/2021 15:49:45'!
test15APortfolioContainingMultiplePortfoliosKnowsItsTransactions

	|mainPortfolio secondaryPortfolio1 secondaryPortfolio2 account1 account2 transaction1 transaction2|

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	transaction1 := Deposit register: 50*peso on: account1.
	transaction2 := Deposit register: 50*peso on: account2.
	
	secondaryPortfolio1 := self portfolioContainingAccounts: (OrderedCollection with: account1).
	secondaryPortfolio2 := self portfolioContainingAccounts: (OrderedCollection with: account2).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio1 with: secondaryPortfolio2).
	
	self assert: mainPortfolio transactions equals: (OrderedCollection with: transaction1 with: transaction2).! !

!PortfoliosTest methodsFor: 'transactions test' stamp: 'Nacho 7/8/2021 15:49:45'!
test18APortfolioContainingAnotherPortfolioAndOneAccountKnowsItsTransactions

	|mainPortfolio secondaryPortfolio secondaryPortfolioAccount account transaction1 transaction2|
	
	secondaryPortfolioAccount := ReceptiveAccount new.
	account := ReceptiveAccount new.
	transaction1 := Deposit register: 50*peso on: secondaryPortfolioAccount.
	transaction2 :=Deposit register: 50*peso on: account.
	
	secondaryPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolioAccount ).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio with: account).
	
	self assert: mainPortfolio transactions equals: (OrderedCollection with: transaction1 with: transaction2) .! !


!PortfoliosTest methodsFor: 'portfolio creation' stamp: 'Nacho 7/8/2021 15:49:45'!
portfolioContainingAccounts: aCollectionOfAccounts

	|aPortfolio|
	
	aPortfolio := Portfolio new.
	aCollectionOfAccounts do: [:anAccount | aPortfolio addAccount: anAccount].
	
	^aPortfolio ! !


!PortfoliosTest methodsFor: 'balance test' stamp: 'Nacho 7/7/2021 01:52:05'!
test01PortfolioHaveZeroAsBalanceWhenCreated

	|aPortfolio|
	
	aPortfolio := Portfolio new.
	
	self assert: aPortfolio balance equals: 0 * peso.! !

!PortfoliosTest methodsFor: 'balance test' stamp: 'Nacho 7/8/2021 15:49:45'!
test04PortfolioWithOneAccountKnowsItsBalance

	|aPortfolio account|
	
	
	account := ReceptiveAccount new.
	Deposit register: 50*peso on: account.
	
	aPortfolio := self portfolioContainingAccounts: (OrderedCollection with: account).
	
	self assert: aPortfolio balance equals: 50 * peso.! !

!PortfoliosTest methodsFor: 'balance test' stamp: 'Nacho 7/8/2021 15:49:45'!
test07PortfolioWithMultipleAccountsKnowsItsBalance

	|aPortfolio account1 account2|

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50*peso on: account1.
	Deposit register: 50*peso on: account2.
	
	aPortfolio := self portfolioContainingAccounts: (OrderedCollection with: account1 with: account2).
	
	self assert: aPortfolio balance equals: 100 * peso.! !

!PortfoliosTest methodsFor: 'balance test' stamp: 'Nacho 7/8/2021 15:49:45'!
test10APortfolioContainingAnotherPortfolioKnowsItsBalance

	|mainPortfolio secondaryPortfolio account|
	
	account := ReceptiveAccount new.
	Deposit register: 50*peso on: account.
	
	secondaryPortfolio := self portfolioContainingAccounts: (OrderedCollection with: account).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio).
	
	self assert: mainPortfolio balance equals: 50*peso.! !

!PortfoliosTest methodsFor: 'balance test' stamp: 'Nacho 7/8/2021 15:49:45'!
test13APortfolioContainingMultiplePortfoliosKnowsItsBalance

	|mainPortfolio secondaryPortfolio1 secondaryPortfolio2 account1 account2|
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 50*peso on: account1.
	Deposit register: 50*peso on: account2.
	
	secondaryPortfolio1 := self portfolioContainingAccounts: (OrderedCollection with: account1).
	secondaryPortfolio2 := self portfolioContainingAccounts: (OrderedCollection with: account2).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio1 with: secondaryPortfolio2).
	
	self assert: mainPortfolio balance equals:100*peso.! !

!PortfoliosTest methodsFor: 'balance test' stamp: 'Nacho 7/8/2021 15:49:45'!
test16APortfolioContainingAnotherPortfolioAndOneAccountKnowsItsBalance

	|mainPortfolio secondaryPortfolio secondaryPortfolioAccount account|
	
	secondaryPortfolioAccount := ReceptiveAccount new.
	account := ReceptiveAccount new.
	Deposit register: 50*peso on: secondaryPortfolioAccount.
	Deposit register: 50*peso on: account.
	
	secondaryPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolioAccount ).
	mainPortfolio := self portfolioContainingAccounts: (OrderedCollection with: secondaryPortfolio with: account).
	
	self assert: mainPortfolio balance equals: 100*peso.! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:43'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:20'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 * peso on: account.
		
	self assert: 100 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:14:24'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	Withdraw register: 50 * peso on: account.
		
	self assert: 50 * peso equals: account balance
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:14'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50 * peso.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:10:22'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	withdraw := Withdraw register: 50 * peso on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:14'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100 * peso.
	withdraw := Withdraw for: 50 * peso.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:12:23'!
test07AccountKnowsItsTransactions 

	| account deposit |
	
	account := ReceptiveAccount new.
	
	deposit := Deposit register: 50 * peso on: account.
		
	self assert: 1 equals: account transactions size.
	self assert: (account transactions includes: deposit).
! !


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Ejercicio'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!TransferTest methodsFor: 'tests' stamp: 'Nacho 7/8/2021 13:04:46'!
test01TransferValueMustBePositive

	|senderAccount receiverAccount|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	self
		should: [Transfer register: 0 * peso betweenSenderAccount: senderAccount andReceiverAccount: receiverAccount . ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Transfer transferValueIsInvalidErrorMessage].! !

!TransferTest methodsFor: 'tests' stamp: 'Nacho 7/8/2021 13:05:07'!
test02TransferDecreasesBalanceOnSenderAccountAndIncreasesBalanceOnReceiverAccount

	|senderAccount receiverAccount|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: senderAccount.
	
	Transfer register: 50 * peso betweenSenderAccount: senderAccount andReceiverAccount: receiverAccount .
	
	self assert: 50 * peso equals: senderAccount balance.
	self assert: 50 * peso  equals:  receiverAccount balance.
! !

!TransferTest methodsFor: 'tests' stamp: 'Nacho 7/8/2021 13:05:21'!
test03ATransferKnowsItsValue

	|senderAccount receiverAccount transferValue|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	Deposit register: 100 * peso on: senderAccount.
	
	transferValue := 50 * peso.
	
	self assert: transferValue equals: (Transfer register: transferValue betweenSenderAccount: senderAccount andReceiverAccount: receiverAccount ) value.! !

!TransferTest methodsFor: 'tests' stamp: 'Nacho 7/8/2021 16:18:57'!
test04ATransactionInTransferKnowsItsCounterparty

	|senderAccount receiverAccount aTransfer transferAssociatedWithdraw transferAssociatedDeposit|
	
	senderAccount := ReceptiveAccount new.
	receiverAccount := ReceptiveAccount new.
	
	aTransfer := Transfer register: 50 * peso betweenSenderAccount: senderAccount andReceiverAccount: receiverAccount.
	
	transferAssociatedWithdraw := aTransfer associatedWithdraw.
	transferAssociatedDeposit := aTransfer associatedDeposit.
	
	self assert: (transferAssociatedWithdraw counterparty) equals: transferAssociatedDeposit.
	self assert: (transferAssociatedDeposit counterparty) equals: transferAssociatedWithdraw.
! !



!classDefinition: #Account category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Account methodsFor: 'as yet unclassified' stamp: 'Nacho 7/7/2021 18:14:38'!
balance
	
	^self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'Nacho 7/7/2021 18:15:30'!
hasRegistered: aTransaction
	
	^self subclassResponsibility.! !

!Account methodsFor: 'as yet unclassified' stamp: 'Nacho 7/7/2021 18:14:58'!
transactions
	
	^self subclassResponsibility.! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #Portfolio
	instanceVariableNames: 'linkedAccounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'Nacho 7/8/2021 15:50:57'!
initialize

	linkedAccounts := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'Nacho 7/8/2021 15:48:12'!
addAccount: anAccount

	^ linkedAccounts add: anAccount.! !

!Portfolio methodsFor: 'main protocol' stamp: 'Nacho 7/8/2021 15:46:51'!
balance

	^linkedAccounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'Nacho 7/8/2021 15:46:56'!
hasRegistered: aTransaction

	^linkedAccounts anySatisfy: [:anAccount | anAccount hasRegistered: aTransaction].! !

!Portfolio methodsFor: 'main protocol' stamp: 'Nacho 7/8/2021 15:47:01'!
transactions
	
	|portfolioTransactions|
	portfolioTransactions := OrderedCollection new.
	
	linkedAccounts do: [:anAccount | portfolioTransactions addAll: (anAccount transactions)].
	
	^portfolioTransactions.! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Ejercicio'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'NR 10/17/2019 15:06:56'!
initialize

	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'Nacho 7/5/2021 20:27:53'!
balance

	^transactions inject: 0*peso into: [:currentBalance :aTransaction | aTransaction effectOnAccountBalance: currentBalance].! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/17/2019 03:28:43'!
hasRegistered: aTransaction

	^ transactions includes: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransaction methodsFor: 'initialization' stamp: 'Nacho 7/5/2021 20:37:26'!
initializeFor: aValue

	value := aValue! !


!AccountTransaction methodsFor: 'value' stamp: 'Nacho 7/5/2021 20:29:19'!
value 

	^value. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'Nacho 7/7/2021 01:10:51'!
for: aValue

	^ self new initializeFor: aValue ! !

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/17/2019 03:22:00'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Deposit methodsFor: 'effect on balance' stamp: 'Nacho 7/5/2021 20:35:35'!
effectOnAccountBalance: currentAccountBalance

	^currentAccountBalance + (self value).! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Withdraw methodsFor: 'effect on balance' stamp: 'Nacho 7/5/2021 20:28:40'!
effectOnAccountBalance: currentAccountBalance

	^currentAccountBalance - (self value).! !


!classDefinition: #AccountTransactionInTransfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #AccountTransactionInTransfer
	instanceVariableNames: 'value associatedTransfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!AccountTransactionInTransfer methodsFor: 'initialization' stamp: 'Nacho 7/8/2021 15:37:11'!
initializeFor: aValue asPartOfTransfer: aTransfer

	value := aValue.
	associatedTransfer := aTransfer.
	! !


!AccountTransactionInTransfer methodsFor: 'value' stamp: 'Nacho 7/7/2021 01:08:56'!
value

	^value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransactionInTransfer class' category: 'ServiciosFinancieros-Ejercicio'!
AccountTransactionInTransfer class
	instanceVariableNames: ''!

!AccountTransactionInTransfer class methodsFor: 'as yet unclassified' stamp: 'Nacho 7/8/2021 15:39:43'!
for: aValue asPartOfTransfer: aTransfer

	^ self new initializeFor: aValue asPartOfTransfer: aTransfer.! !

!AccountTransactionInTransfer class methodsFor: 'as yet unclassified' stamp: 'Nacho 7/8/2021 15:39:33'!
register: aValue on: account asPartOfTransfer: aTransfer

	| transaction |
	
	transaction := self for: aValue asPartOfTransfer: aTransfer .
	account register: transaction.
		
	^ transaction! !


!classDefinition: #DepositInTransfer category: 'ServiciosFinancieros-Ejercicio'!
AccountTransactionInTransfer subclass: #DepositInTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!


!DepositInTransfer methodsFor: 'main protocol' stamp: 'Nacho 7/7/2021 01:12:56'!
counterparty

	^associatedTransfer associatedWithdraw.! !

!DepositInTransfer methodsFor: 'main protocol' stamp: 'Nacho 7/7/2021 01:09:24'!
effectOnAccountBalance: currentAccountBalance

	^currentAccountBalance + (self value).! !


!classDefinition: #WithdrawInTransfer category: 'ServiciosFinancieros-Ejercicio'!
AccountTransactionInTransfer subclass: #WithdrawInTransfer
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!


!WithdrawInTransfer methodsFor: 'main protocol' stamp: 'Nacho 7/7/2021 01:13:24'!
counterparty

	^associatedTransfer associatedDeposit! !

!WithdrawInTransfer methodsFor: 'main protocol' stamp: 'Nacho 7/7/2021 01:09:16'!
effectOnAccountBalance: currentAccountBalance

	^currentAccountBalance - (self value).! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Ejercicio'!
Object subclass: #Transfer
	instanceVariableNames: 'associatedDeposit associatedWithdraw'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Ejercicio'!

!Transfer methodsFor: 'main protocol' stamp: 'Nacho 7/5/2021 17:56:03'!
associatedDeposit

	^associatedDeposit.! !

!Transfer methodsFor: 'main protocol' stamp: 'Nacho 7/5/2021 17:55:52'!
associatedWithdraw

	^associatedWithdraw.! !

!Transfer methodsFor: 'main protocol' stamp: 'Nacho 7/7/2021 01:14:38'!
value

	^associatedDeposit value.
! !


!Transfer methodsFor: 'initialization' stamp: 'Nacho 7/7/2021 16:15:36'!
initializeFor: aValue associatedWithWithdraw: aWithdraw andDeposit: aDeposit.

	associatedWithdraw := aWithdraw.
	associatedDeposit := aDeposit.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Ejercicio'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'error message- private' stamp: 'Nacho 7/5/2021 18:21:06'!
transferValueIsInvalidErrorMessage

	^'Transfer value must be positive'.! !


!Transfer class methodsFor: 'instance creation' stamp: 'Nacho 7/8/2021 15:40:43'!
register: aValue betweenSenderAccount: aSenderAccount andReceiverAccount: aReceiverAccount
	
	|associatedWithdraw associatedDeposit aTransfer|

	(aValue > 0) ifFalse: [self error: self transferValueIsInvalidErrorMessage].
	
	aTransfer := self new.
	associatedWithdraw := WithdrawInTransfer register: aValue on: aSenderAccount asPartOfTransfer: aTransfer.
	associatedDeposit := DepositInTransfer register: aValue on: aReceiverAccount asPartOfTransfer: aTransfer.
	
	aTransfer initializeFor: aValue associatedWithWithdraw: associatedWithdraw andDeposit:associatedDeposit.
	
	^aTransfer.! !
