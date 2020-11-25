# PWBTracers
```Smalltalk

 Metacello new
    	githubUser: 'mahugnon' project: 'PWBTracers' commitish: 'master' path: 'src';
    	baseline: 'PWBTracers';
	 onConflict: [ :e | e useIncoming ];
        onUpgrade: [ :e | e useIncoming ];
        load
```
