'<deployment>
	<cluster kfactor="${kfactor}" sitesperhost="${sitesperhost}"/>
	<dr id="${dr_id}" role="xdcr">
		<connection source="${source_str}"/>
	</dr>
	<import/>
</deployment>'