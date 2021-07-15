!classDefinition: #AccountSummaryTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountSummaryTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:43:18'!
test01AccountWithoutTransactionsSummaryOnlyShowsBalanceIsEqualToZero

	|anAccount anAccountSummary|
	
	anAccount := ReceptiveAccount new.
	anAccountSummary := AccountSummary for: anAccount.
	
	self assert: anAccountSummary summary equals: (OrderedCollection with:'Balance = 0 pesos').! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:34:15'!
test02AccountWithOneDepositSummaryShowsTheDepositAndBalance

	|anAccount anAccountSummary|
	
	anAccount := ReceptiveAccount new.
	Deposit register: 50*peso on: anAccount.
	anAccountSummary := AccountSummary for: anAccount.
	
	self assert: anAccountSummary summary equals: (OrderedCollection with: 'Depósito por 50 pesos' with:'Balance = 50 pesos').! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:34:46'!
test03AccountWithOneWithdrawSummaryShowsTheWithdrawAndBalance

	|anAccount anAccountSummary|
	
	anAccount := ReceptiveAccount new.
	Withdraw register: 50*peso on: anAccount.
	anAccountSummary := AccountSummary for: anAccount.
	
	self assert: anAccountSummary summary equals: (OrderedCollection with: 'Extracción por 50 pesos' with:'Balance = -50 pesos').! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:37:10'!
test04SenderAccountWithOneTransferSummaryShowsTheTransferWithdrawAndBalance

	|anAccount1 anAccount2 anAccountSummary|
	
	anAccount1 := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.

	Transfer amount: 50*peso from: anAccount1 to: anAccount2. 
	
	anAccountSummary := AccountSummary for: anAccount1.
	
	self assert: anAccountSummary summary equals: (OrderedCollection with: 'Salida por transferencia de 50 pesos' with:'Balance = -50 pesos').! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:37:38'!
test05ReceiverAccountWithOneTransferSummaryShowsTheTransferDepositAndBalance

	|anAccount1 anAccount2 anAccountSummary|
	
	anAccount1 := ReceptiveAccount new.
	anAccount2 := ReceptiveAccount new.

	Transfer amount: 50*peso from: anAccount1 to: anAccount2. 
	
	anAccountSummary := AccountSummary for: anAccount2.
	
	self assert: anAccountSummary summary equals:(OrderedCollection with: 'Entrada por transferencia de 50 pesos' with:'Balance = 50 pesos').! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:38:25'!
test06AccountWithMultipleTransactionsSummaryShowsTransactionsAndBalance

	|mainAccount secondaryAccount mainAccountSummary|
	
	mainAccount := ReceptiveAccount new.
	secondaryAccount := ReceptiveAccount new.
	
	Deposit register: 200* peso on: mainAccount.
	Withdraw register: 100*peso on: mainAccount.
	Transfer amount: 50*peso from: mainAccount to: secondaryAccount.
	Transfer amount: 25*peso from: secondaryAccount to: mainAccount.
	
	mainAccountSummary := AccountSummary for: mainAccount.
	
	self assert: mainAccountSummary summary equals: (OrderedCollection with: 'Depósito por 200 pesos'
																with: 'Extracción por 100 pesos'
																with: 'Salida por transferencia de 50 pesos'
																with: 'Entrada por transferencia de 25 pesos'
																with:'Balance = 75 pesos').! !

!AccountSummaryTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:40:39'!
test07PortfolioSummaryShowsTransactionsAndBalance

	|simplePortfolio simplePortfolioAccount composedPortofolio composedPortfolioAccount composedPortofolioAccountSummary|

	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortofolioAccountSummary := AccountSummary for: composedPortofolio.
	
	self assert: composedPortofolioAccountSummary summary equals: (OrderedCollection with: 'Depósito por 100 pesos'
																	   with: 'Extracción por 50 pesos'
																	   with: 'Balance = 50 pesos').
	
	! !


!classDefinition: #AccountTransferNetTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #AccountTransferNetTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransferNetTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:47:56'!
test01AccountTransferNetOfAccountWithoutTransfersIsEqualToZero
	
	|anAccount accountTransferNet|
	
	anAccount := ReceptiveAccount new.
	accountTransferNet := AccountTransferNet for: anAccount.

	self assert: accountTransferNet transferNet equals: 0*peso.! !

!AccountTransferNetTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:47:48'!
test02AccountTransferNetCanBeCalculatedWithOneTransfer
	
	|senderAccount receiverAccount senderAccountTransferNet receiverAccountTransferNet|
	
	senderAccount := ReceptiveAccount new.
	senderAccountTransferNet := AccountTransferNet for: senderAccount.
	
	receiverAccount := ReceptiveAccount new.
	receiverAccountTransferNet := AccountTransferNet for: receiverAccount.
	
	Transfer amount: 50*peso from: senderAccount to: receiverAccount.

	self assert: receiverAccountTransferNet transferNet equals: 50*peso.
	self assert: senderAccountTransferNet transferNet equals: -50*peso.! !

!AccountTransferNetTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:47:39'!
test03AccountTransferNetCanBeCalculatedWithMultipleTransfers
	
	|anAccount1 anAccount2 anAccount1TransferNet anAccount2TransferNet|
	
	anAccount1 := ReceptiveAccount new.
	anAccount1TransferNet := AccountTransferNet for: anAccount1.
	
	anAccount2 := ReceptiveAccount new.
	anAccount2TransferNet := AccountTransferNet for: anAccount2.
	
	Transfer amount: 50*peso from: anAccount1 to: anAccount2.
	Deposit register: 10*peso on: anAccount1.
	Transfer amount: 20*peso from: anAccount2 to: anAccount1.

	self assert: anAccount2TransferNet transferNet equals: 30*peso.
	self assert: anAccount1TransferNet transferNet equals: -30*peso.! !

!AccountTransferNetTest methodsFor: 'as yet unclassified' stamp: 'Nacho 7/13/2021 01:48:23'!
test04PortfolioTransferNetCanBeCalculatedWithMultipleTransfers
	
	|simplePortfolio simplePortfolioAccount composedPortofolio anotherAccount composedPortfolioTransferNet|
	
	anotherAccount := ReceptiveAccount new.
	simplePortfolioAccount := ReceptiveAccount new.
	
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio.
	composedPortfolioTransferNet := AccountTransferNet for: composedPortofolio.
	
	
	Transfer amount: 50*peso from: anotherAccount to: simplePortfolioAccount.
	Transfer amount: 20*peso from: simplePortfolioAccount to: anotherAccount.
	
	self assert: composedPortfolioTransferNet transferNet equals: 30*peso.
! !


!classDefinition: #PortfolioTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:00'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:06'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:12'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100 * peso))! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:18'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:27:26'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:08'!
test08PortfolioTransactionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 * peso on: account.
	anotherAccountWithdraw := Withdraw register: 100 * peso on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'LL 7/1/2021 03:28:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 * peso on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 * peso on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !


!classDefinition: #ReceptiveAccountTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'Nacho 7/12/2021 20:20:04'!
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


!classDefinition: #TransferTest category: 'ServiciosFinancieros-Solucion'!
TestCase subclass: #TransferTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:07:03'!
test01ATransferDecreasesBalanceFromOriginAccountAndIncreasesItForDestinationAccount

	| destinationAccount originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 8 * peso equals: originAccount balance.
	self assert: 12 * peso equals: destinationAccount balance.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 21:12:28'!
test02ATransferKnowsItsValue

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: 2 * peso equals: transfer value.! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:44'!
test03DepositLegKnowsItsWithdrawCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer withdrawLeg equals: transfer depositLeg withdrawLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:01:51'!
test04WithdrawLegKnowsItsDepositCounterpart

	| destinationAccount originAccount transfer |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: destinationAccount.
	
	transfer := Transfer amount: 2 * peso from: originAccount to: destinationAccount.
	
	self assert: transfer depositLeg equals: transfer withdrawLeg depositLeg! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:36'!
test05OriginAndDestinationAccountsCannotBeTheSame

	| originAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	self should: [ Transfer amount: 2 * peso from: originAccount to: originAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferToOriginErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !

!TransferTest methodsFor: 'as yet unclassified' stamp: 'LL 9/20/2020 23:02:44'!
test06CannotTransferAZeroAmount

	| originAccount destinationAccount |
	
	originAccount := ReceptiveAccount new.
	Deposit register: 10 * peso on: originAccount.
	
	destinationAccount := ReceptiveAccount new.
	Deposit register: 5 * peso on: destinationAccount.
	
	self should: [ Transfer amount: 0 from: originAccount to: destinationAccount ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Transfer cannotTransferZeroErrorDescription equals: anError messageText.
			self assert: 10 * peso equals: originAccount balance.
		]
! !


!classDefinition: #Account category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !

!Account methodsFor: 'main protocol' stamp: 'Nacho 7/12/2021 18:22:08'!
transferNet
	
	^self transactions 
		inject: 0*peso
		into: [ :currentBalance :transaction | 
			((transaction isKindOf: TransferDepositLeg) or: [transaction isKindOf: TransferWithdrawLeg ]) ifTrue: [transaction affectBalance: currentBalance] 
																							     ifFalse: [currentBalance]].! !


!Account methodsFor: 'private' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: 'ServiciosFinancieros-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Portfolio methodsFor: 'initialization' stamp: 'LL 7/1/2021 03:21:03'!
initialize

	accounts := OrderedCollection new.! !


!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'main protocol' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'accounts management' stamp: 'LL 7/1/2021 03:21:12'!
add: accountToAdd
	
	accounts add: accountToAdd.
	! !


!Portfolio methodsFor: 'private' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !


"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: 'ServiciosFinancieros-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: 'ServiciosFinancieros-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'main protocol' stamp: 'Nacho 7/12/2021 20:27:27'!
balance

	^transactions 
		inject: 0 * peso
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !

!ReceptiveAccount methodsFor: 'main protocol' stamp: 'NR 10/21/2019 18:55:56'!
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


!ReceptiveAccount methodsFor: 'private' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !


!classDefinition: #AccountTransaction category: 'ServiciosFinancieros-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'accept' stamp: 'Nacho 7/15/2021 00:54:40'!
accept: aReport

	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: 'ServiciosFinancieros-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'NR 10/21/2019 18:54:27'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'as yet unclassified' stamp: 'Nacho 7/15/2021 00:53:28'!
accept: aReport

	^ aReport visitDeposit: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: 'ServiciosFinancieros-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferLeg methodsFor: 'value' stamp: 'LL 9/20/2020 22:27:32'!
value

	^transfer value! !


!TransferLeg methodsFor: 'initialization' stamp: 'Nacho 7/15/2021 00:31:45'!
initializeFor: aTransfer

	transfer := aTransfer! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: 'ServiciosFinancieros-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'as yet unclassified' stamp: 'Nacho 7/15/2021 00:31:45'!
of: aTransfer on: anAccount

	| transaction |
	
	transaction := self new initializeFor: 	aTransfer.
	anAccount register: transaction.	
	
	^transaction! !


!classDefinition: #TransferDepositLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferDepositLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferDepositLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:26:10'!
withdrawLeg

	^transfer withdrawLeg! !


!TransferDepositLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:49'!
affectBalance: aBalance

	^aBalance + self value! !


!TransferDepositLeg methodsFor: 'as yet unclassified' stamp: 'Nacho 7/15/2021 00:53:37'!
accept: aReport

	^ aReport visitTransferDeposit: self.! !


!classDefinition: #TransferWithdrawLeg category: 'ServiciosFinancieros-Solucion'!
TransferLeg subclass: #TransferWithdrawLeg
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!TransferWithdrawLeg methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:25:47'!
depositLeg

	^transfer depositLeg! !


!TransferWithdrawLeg methodsFor: 'balance' stamp: 'LL 9/20/2020 22:27:55'!
affectBalance: aBalance

	^aBalance - self value! !


!TransferWithdrawLeg methodsFor: 'as yet unclassified' stamp: 'Nacho 7/15/2021 00:53:43'!
accept: aReport

	^ aReport visitTransferWithdraw: self.! !


!classDefinition: #Withdraw category: 'ServiciosFinancieros-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'as yet unclassified' stamp: 'Nacho 7/15/2021 00:52:17'!
accept: aReport

	^ aReport visitWithdraw: self.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: 'ServiciosFinancieros-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Report
	instanceVariableNames: 'account'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Report methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:52:38'!
visitDeposit: aDeposit

	^self subclassResponsibility.! !

!Report methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:52:51'!
visitTransferDeposit: aTransferDeposit

	^self subclassResponsibility.! !

!Report methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:53:03'!
visitTransferWithdraw: aTransferWithdraw

	^self subclassResponsibility.! !

!Report methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:53:13'!
visitWithdraw: aWithdraw

	^self subclassResponsibility.! !


!Report methodsFor: 'initialization' stamp: 'Nacho 7/15/2021 00:32:05'!
initializeFor: anAccount

	account := anAccount.! !


!classDefinition: #AccountSummary category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountSummary methodsFor: 'main protocol' stamp: 'Nacho 7/15/2021 00:51:39'!
summary
	|accountSummary accountBalance|
	
	accountSummary := OrderedCollection new.
	account transactions do: [:aTransaction | accountSummary add: ( aTransaction accept: self) ].
	
	accountBalance := account balance.
	accountSummary add: 'Balance = ', (accountBalance asString).
	^accountSummary.
	
! !


!AccountSummary methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:52:38'!
visitDeposit: aDeposit

	^'Depósito por ', ((aDeposit value) asString).! !

!AccountSummary methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:52:51'!
visitTransferDeposit: aTransferDeposit

	^'Entrada por transferencia de ', ((aTransferDeposit value) asString).! !

!AccountSummary methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:53:03'!
visitTransferWithdraw: aTransferWithdraw

	^'Salida por transferencia de ', ((aTransferWithdraw value) asString).! !

!AccountSummary methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:53:13'!
visitWithdraw: aWithdraw

	^'Extracción por ', ((aWithdraw value) asString).! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: 'ServiciosFinancieros-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'as yet unclassified' stamp: 'Nacho 7/15/2021 00:31:46'!
for: anAccount

	^self new initializeFor: anAccount.! !


!classDefinition: #AccountTransferNet category: 'ServiciosFinancieros-Solucion'!
Report subclass: #AccountTransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!AccountTransferNet methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:52:38'!
visitDeposit: aDeposit

	^0*peso.

	

	! !

!AccountTransferNet methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:52:51'!
visitTransferDeposit: aTransferDeposit

	^aTransferDeposit value.

	

	! !

!AccountTransferNet methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:53:03'!
visitTransferWithdraw: aTransferWithdraw

	^aTransferWithdraw value negated.

	

	! !

!AccountTransferNet methodsFor: 'visitors' stamp: 'Nacho 7/15/2021 00:53:13'!
visitWithdraw: aWithdraw

	^0*peso.

	

	! !


!AccountTransferNet methodsFor: 'main protocol' stamp: 'Nacho 7/15/2021 00:51:31'!
transferNet
	
	|currentNet|
	
	currentNet := 0 * peso.
	
	account transactions do: [:aTransaction | 			currentNet := currentNet + (aTransaction accept: self)].
	
	^currentNet.

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNet class' category: 'ServiciosFinancieros-Solucion'!
AccountTransferNet class
	instanceVariableNames: ''!

!AccountTransferNet class methodsFor: 'as yet unclassified' stamp: 'Nacho 7/12/2021 21:36:17'!
for: anAccount

	^AccountTransferNet new initializeFor: anAccount.! !


!classDefinition: #Transfer category: 'ServiciosFinancieros-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value withdrawLeg depositLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'ServiciosFinancieros-Solucion'!

!Transfer methodsFor: 'value' stamp: 'LL 9/20/2020 21:13:00'!
value

	^value! !


!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 22:39:46'!
depositLeg

	^depositLeg! !

!Transfer methodsFor: 'accessing' stamp: 'LL 9/20/2020 21:25:56'!
withdrawLeg
	
	^withdrawLeg! !


!Transfer methodsFor: 'initialization' stamp: 'LL 9/20/2020 21:25:21'!
initializeWith: aValue withdrawLeg: aWithdraw depositLeg: aDeposit

	value := aValue.
	withdrawLeg := aWithdraw.
	depositLeg := aDeposit! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: 'ServiciosFinancieros-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:57:30'!
cannotTransferToOriginErrorDescription
	
	^'Transfer destionation cannot be the origin account'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:00:53'!
cannotTransferZeroErrorDescription

	^'Transfer amount should be positive'! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 22:56:35'!
signalCannotTransferToOrigin
	
	self error: self cannotTransferToOriginErrorDescription! !

!Transfer class methodsFor: 'errors' stamp: 'LL 9/20/2020 23:06:17'!
signalCannotTransferZero

	self error: self cannotTransferZeroErrorDescription! !


!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:05:22'!
assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount

	self assertCanTransferTo: destinationAccount from: originAccount.
	self assertCanTransfer: anAmountOfMoney! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:11:50'!
assertCanTransfer: anAmountOfMoney

	^ anAmountOfMoney isZero ifTrue: [ self signalCannotTransferZero ]! !

!Transfer class methodsFor: 'assertions' stamp: 'LL 9/20/2020 23:04:58'!
assertCanTransferTo: destinationAccount from: originAccount

	^ originAccount = destinationAccount ifTrue: [ self signalCannotTransferToOrigin ]! !


!Transfer class methodsFor: 'instance creation' stamp: 'LL 9/20/2020 23:11:34'!
amount: anAmountOfMoney from: originAccount to: destinationAccount 
	
	| transfer depositLeg withdrawLeg |
	
	self assert: anAmountOfMoney canBeTransferedTo: destinationAccount from: originAccount.
	
	transfer := self new.
	
	withdrawLeg := TransferWithdrawLeg of: transfer on: originAccount.
	depositLeg := TransferDepositLeg of: transfer on: destinationAccount.
	
	^transfer initializeWith: anAmountOfMoney withdrawLeg: withdrawLeg depositLeg: depositLeg
	
	
	! !
