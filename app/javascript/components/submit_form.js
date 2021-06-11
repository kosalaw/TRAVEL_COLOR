export const listen_to_form = () => {
  if (document.getElementById('compare_form')) {
    document.getElementById('compare_form').addEventListener('change', () => {
      document.getElementById('compare_form').submit();
    })
  }
}
