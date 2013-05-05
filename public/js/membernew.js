function showAddTeamPanel() {
	$('#team-add-panel').modal({
		keyboard: false
	});
}

function addTeam(){
	$.post('/team/new',{
		'team[name]':$('#team_name').val()
	},function(resData){
		$('#team-add-panel').modal('hide');
		if(resData.success){
			$('<option/>').appendTo($('#teamlist')).val(resData.team._id).text(resData.team.name);
			$("#ats").show();
		}else{
			$("#atf").show();
		}
	});
}