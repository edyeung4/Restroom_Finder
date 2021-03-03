$(function(){
    $('tbody').on("click", '.delete', function() {
        $(this).closest(".check-table tr").remove();
    });

    $('tbody').on('click','.update', function(){
        if($(this).hasClass('on')){
	    disabled = true;
            $(this).prop('value','Update');
            $(this).prop('type', 'submit');
	    $(this).trigger('click');
            $(this).removeClass('on');
            
        }else{
            disabled = false;
            $(this).addClass('on');
	    $(this).prop('value','Save');
        }
        $(this).parents('tr').find('input').attr('disabled',disabled); 
        $(this).parents('tr').find('select').attr('disabled',disabled); 
    }); 
})
